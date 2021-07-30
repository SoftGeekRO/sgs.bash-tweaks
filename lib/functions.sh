#!/bin/bash

## Functions

add_auth_key () {
    ssh-copy-id "$@"
}

extract () {
    if [ -f "$1" ] ; then
        case $1 in
            *.tar.bz2)        tar xjf     "$1"        ;;
            *.tar.gz)         tar xzf     "$1"        ;;
            *.bz2)            bunzip2     "$1"        ;;
            *.rar)            unrar x     "$1"        ;;
            *.gz)             gunzip      "$1"        ;;
            *.tar)            tar xf      "$1"        ;;
            *.tbz2)           tar xjf     "$1"        ;;
            *.tgz)            tar xzf     "$1"        ;;
            *.zip)            unzip       "$1"        ;;
            *.Z)              uncompress  "$1"        ;;
            *.7z)             7zr e       "$1"        ;;
            *)                echo        "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

dls () {
 # dls will list directories instead of files in the current working directory. 
 echo `ls -l | grep "^d" | awk '{ print $9 }' | tr -d "/"`
}

dgrep() {
    # A recursive, case-insensitive grep that excludes binary files
    grep -iR "$@" * | grep -v "Binary"
}

dfgrep() {
    # A recursive, case-insensitive grep that excludes binary files
    # and returns only unique filenames
    grep -iR "$@" * | grep -v "Binary" | sed 's/:/ /g' | awk '{ print $1 }' | sort | uniq
}

psgrep() {
    # pgrep, it shows the entire line of ps rather than just the PID
    if [ ! -z "$1" ] ; then
        echo "Grepping for processes matching $1..."
        ps aux | grep "$1" | grep -v grep
    else
        echo "!! Need name to grep for"
    fi
}

killit() {
    # Kills any process that matches a regexp passed to it
    ps aux | grep -v "grep" | grep "$@" | awk '{print $2}' | xargs sudo kill
}

# make a dir and cd into it
mkcd () {  
    mkdir -p "$@" && cd "$@" || exit
}

#copy and go to dir
cpcd () {
    if [ -d "$2" ];then
        cp "$1" "$2" && cd "$2" || exit
    else
        cp "$1" "$2"
    fi
}

#move and go to dir
mvcd () {
    if [ -d "$2" ];then
        mv "$1" "$2" && cd "$2" || exit
    else
        mv "$1" "$2"
    fi
}

portslay () {
    # If you need to kill a process on a particular port, but you don't know the process, portslay handles that.
    kill -9 `lsof -i tcp:$1 | tail -1 | awk '{ print $2;}'`
}

# Network utils

shell () {
  ps | pgrep `echo $$` | awk '{ print $4 }'
}

lso () {
  # display the permision in octal format
  ls -l "$@" | awk '{k=0;for(i=0;i<=8;i++)k+=((substr($1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(" %0o ",k);print}';
}


####
# Docker utils functions
####

docker_rmi_tag() {
  tag=${1-none}
  docker images | grep "$tag" | awk '{print $1 ":" $2}' | xargs docker rmi -f
}

####
# Python Virtual ENV
####
# Automatically activate Git projects' virtual environments based on the
# directory name of the project. Virtual environment name can be overridden
# by placing a .venv file in the project root with a virtualenv name in it
function workon_cwd {
    # Check that this is a Git repo
    GIT_DIR=$(git rev-parse --git-dir 2> /dev/null)
    if [ $? == 0 ]; then
        # Find the repo root and check for virtualenv name override
        GIT_DIR=$(cd "$GIT_DIR"|| pwd)
        PROJECT_ROOT=$(dirname "$GIT_DIR")
        ENV_NAME=$(basename "$PROJECT_ROOT")
        if [ -f "$PROJECT_ROOT/.venv" ]; then
            ENV_NAME=$(cat "$PROJECT_ROOT/.venv")
        fi
        # Activate the environment only if it is not already active
        if [ "$VIRTUAL_ENV" != "$WORKON_HOME/$ENV_NAME" ]; then
            if [ -e "$WORKON_HOME/$ENV_NAME/bin/activate" ]; then
              echo Activated virtualenv "${ENV_NAME}".
              workon "${ENV_NAME}" && export CD_VIRTUAL_ENV="$ENV_NAME"
            fi
        fi
    elif [ "${CD_VIRTUAL_ENV}" ]; then
        # We've just left the repo, deactivate the environment
        # Note: this only happens if the virtualenv was activated automatically
        echo Deactivate virtualenv "${ENV_NAME}".
        deactivate && unset CD_VIRTUAL_ENV
    fi
}

# New cd function that does the virtualenv magic
function venv_cd {
    cd "$@" && workon_cwd
}
