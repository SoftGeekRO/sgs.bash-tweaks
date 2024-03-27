#!/bin/bash

BASH_TWEAKS_DIR=/usr/share/sgs/sgs.bash-tweaks
# export CDPATH=$CDPATH:.:~

function import_bash_files() {
	[[ -f "$1" ]] && . "$1" || echo ":: Shell Tweaks failed to import file $1" >&2
}

for file in $BASH_TWEAKS_DIR/lib/*.sh; do
  [ -e "$file" ] || continue
  if [ -x "$file" ]; then
    source "$file"
  else
    echo "File is not executable";
  fi
done
unset -f import_bash_files

#
# # Tell bash to execute this function just before displaying its prompt.
PROMPT_COMMAND=set_bash_prompt
#
# virtualenv_path="$(which virtualenv)"
# if [ -x "${virtualenv_path}" ]; then
#   VIRTUALENVWRAPPER_PYTHON="$(which python)"
#   export VIRTUALENVWRAPPER_PYTHON
#
#   VIRTUALENVWRAPPER_VIRTUALENV="${virtualenv_path}"
#   export VIRTUALENVWRAPPER_VIRTUALENV
#
#   export WORKON_HOME=${WORK_ZONE_PATH}/.virtualenvs
#   export PROJECT_HOME="${WORK_ZONE_APPS}"
#   source /usr/local/bin/virtualenvwrapper.sh
# fi
