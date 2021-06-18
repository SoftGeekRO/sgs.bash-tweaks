#!/bin/bash

#############################
# ProGeek bash tweaks setup #
#############################

trap 'cleanup; exit 1' HUP INT QUIT TERM

PWD="$(dirname "$(readlink -f "$0")")"

BASENAME=$(basename "$0")
USAGE="Usage: $BASENAME {install | uninstall | reinstall}"

INSTALL_DIR=$HOME/.shell_tweaks
DIRECTORIES="lib plugins other"
BASHRC_LINE="[[ -f $INSTALL_DIR/shell_tweaks ]] && . $INSTALL_DIR/shell_tweaks"

log_message() {
	echo ":: $1"
}


case "$1" in
      install)
        if [ ! -d "$INSTALL_DIR" ]
        then
            mkdir "$INSTALL_DIR"
            cp shell_tweaks "$INSTALL_DIR/shell_tweaks"
            for DIRECTORY in $DIRECTORIES
            do
              mkdir "$INSTALL_DIR"/"$DIRECTORY"
              cp -ra "$DIRECTORY" "$INSTALL_DIR"/
            done

            ln -srf "$INSTALL_DIR/other/.nanorc" "$HOME/.nanorc"

            LINE=$(grep -n "${BASHRC_LINE}" "$HOME"/.bashrc | awk -F':' '{print $1;}')
            [[ -z $LINE ]] && echo "${BASHRC_LINE}" >> "$HOME"/.bashrc

            motd_tmp=<(find "$INSTALL_DIR/other/motd/*" -print0)
            while IFS= read -r -d '' motd_path
            do
              ln -srf "$motd_path" /etc/update-motd.d/"$(basename "$motd_path")"
            done < "$motd_tmp"

            echo ""
            log_message "Shell Tweaks install complete!"
            log_message "Restart your terminal or source your .bashrc file to load new Shell Tweaks"
            echo ""
        else
          log_message "Shell Tweaks directory already exists (skipping)"
        fi
        ;;
      uninstall)
        log_message "Uninstall the bash tweaks"

        LINE=$(grep -n "${BASHRC_LINE}" $HOME/.bashrc | awk -F':' '{print $1;}')
        [[ -n $LINE ]] && sed -i -e "${LINE}d" $HOME/.bashrc

        unlink "$HOME/.nanorc" > /dev/null 2>&1

        rm -rf /etc/update-motd.d/*

        [[ -d $INSTALL_DIR ]] && rm -rf "$INSTALL_DIR"
        ;;
      reinstall)
        ./"$0" uninstall
        ./"$0" install
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
