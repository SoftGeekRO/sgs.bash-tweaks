#!/bin/bash

#############################
# ProGeek bash tweaks setup #
#############################

trap 'cleanup; exit 1' HUP INT QUIT TERM

PWD="$(dirname "$(readlink -f "$0")")"

BASENAME=$(basename "$0")
USAGE="Usage: $BASENAME {install | uninstall | reinstall}"

INSTALL_DIR=$HOME/.bashelicious
DIRECTORIES="lib plugins"
BASHRC_LINE="[[ -f $INSTALL_DIR/bashelicious ]] && . $INSTALL_DIR/bashelicious"

log_message() {
	echo ":: $1"
}


case "$1" in
      install)
        echo ""
        log_message "Bashelicious install complete!"
        log_message "Restart your terminal or source your .bashrc file to load bashelicious"
        echo ""
        ;;
      uninstall)

        log_message "Uninstall the bash tweaks"
        ;;
      reinstall)
        ./$0 uninstall
        ./$0 install
        ;;
      *)
        echo $USAGE
        exit 1
        ;;

esac

## enable programmable completion features (you don't need to enable
## this, if it's already enabled in /etc/bash.bashrc and /etc/profile
## sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi
#
#if [ -f /etc/profile.d/bash_completion.sh ]; then
#    source /etc/profile.d/bash_completion.sh
#fi
#
#if [ -d ~/pg.bash-toys ]; then
#    . ~/pg.bash-toys/aliases
#    . ~/pg.bash-toys/variabiles
#    . ~/pg.bash-toys/functions
#    . ~/pg.bash-toys/fancyPrompt
#fi
#
## Tell bash to execute this function just before displaying its prompt.
#PROMPT_COMMAND=set_bash_prompt
#
#if [ -x "$(which virtualenv)" ]; then
#    export VIRTUALENVWRAPPER_PYTHON=$(which python)
#    export VIRTUALENVWRAPPER_VIRTUALENV=$(which virtualenv)
#    export WORKON_HOME=${PG_ZONE}/.virtualenvs
#    export PROJECT_HOME=${PG_ZONE}/apps
#    export VIRTUALENVWRAPPER_SCRIPT=/usr/share/virtualenvwrapper/virtualenvwrapper.sh
#    source /usr/share/virtualenvwrapper/virtualenvwrapper_lazy.sh
#fi
