#!/bin/bash

# Determine git branch name
parse_git_branch() {
  git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Detect whether the current directory is a git repository.
function is_git_repository() {
  git branch >/dev/null 2>&1
}

# Determine the branch/state information for this git repository.
function set_git_branch() {
  # Capture the output of the "git status" command.
  git_status="$(git status 2>/dev/null)"

  # Set color based on clean/staged/dirty.
  if [[ ${git_status} =~ "working directory clean" ]]; then
    state="${BGreen}"
  elif [[ ${git_status} =~ "Changes to be committed" ]]; then
    state="${BYellow}"
  else
    state="${LGreen}"
  fi

  # Set arrow icon based on status against remote.
  remote_pattern="Your branch is (.*) (of|by|with)"
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    #    echo "ofof = ${BASH_REMATCH[1]}"
    if [[ ${BASH_REMATCH[1]} == ahead* ]]; then
      remote="↑"
    elif [[ ${BASH_REMATCH[1]} == behind* ]]; then
      remote="↓"
    else
      remote="--"
    fi
  else
    remote=""
  fi

  diverge_pattern="Your branch and (.*) have diverged"
  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="↕"
  fi

  # Get the name of the branch.
  branch_pattern="^(# )?On branch ([^${IFS}]*)"
  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[2]}
  fi
  branch="$(git rev-parse --abbrev-ref HEAD)" # replace all 4 lines with this.

  # Set the final branch string.
  #  echo "bran ${branch}"
  BRANCH=":${state}(${branch})${remote}${Color_Off}"
}

# Return the prompt symbol to use, colorized based on the return value of the
# previous command.
function set_prompt_symbol() {
  if test "$1" -eq 0; then
    PROMPT_SYMBOL="${Green}\\\$${Color_Off} "
  else
    PROMPT_SYMBOL="${Red}\\\$${Color_Off} "
  fi
}

# Determine active Python virtualenv details.
function set_virtualenv() {
  if test -z "$VIRTUAL_ENV"; then
    PYTHON_VIRTUALENV=""
  else
    PYTHON_VIRTUALENV=":${LBlue}[$(basename "${VIRTUAL_ENV}")]${Color_Off}"
  fi
}

# Set the full bash prompt.
function set_bash_prompt() {
  local last_command=$? # Must come first!

  # Set the PROMPT_SYMBOL variable. We do this first so we don't lose the
  # return value of the last command.
  set_prompt_symbol $?

  PS1=""
  # Set the PYTHON_VIRTUALENV variable.
  set_virtualenv

  # Set the BRANCH variable.
  if is_git_repository; then
    set_git_branch
  else
    BRANCH=''
  fi

  if [[ $last_command == 0 ]]; then
    PS1+="${Green}${CHECKMARK} "
  else
    PS1+="${BRed}${FANCYX} "
  fi
  if [[ $EUID == 0 ]]; then
    USER_COLOR="${Red}\\u@\\h${Color_Off}"
  else
    USER_COLOR="${Green}\\u@\\h${Color_Off}"
  fi

  PS1+="${PYTHON_VIRTUALENV}${USER_COLOR}:\w${BRANCH}${PROMPT_SYMBOL}"
}
