#!/bin/bash

######################################
# SoftGeek Romania bash tweaks setup #
######################################
trap 'cleanup; exit 1' HUP INT QUIT TERM

E_NOTROOT=87 # Non-root exit error.

WORKING_DIR="$(dirname "$(readlink -f "$0")")"
BASENAME=$(basename $(pwd))
SCRIPT_NAME=$(basename "$0")

USAGE="Usage: $SCRIPT_NAME {install | uninstall | reinstall}"

INSTALL_PATH="/usr/share/sgs/"
INSTALL_DIR="${INSTALL_PATH}${BASENAME}"
BASHRC_PATCH="[[ -f $INSTALL_DIR/bash-tweaks.sh ]] && . $INSTALL_DIR/bash-tweaks.sh"

# Fancy red-colored `error` function with `stderr` redirection with `exit`.
error () {
    { printf '\E[31m'; echo ":: $@"; printf '\E[0m'; } >&2
}

info() {
  { printf '\E[32m'; echo ":: $1"; printf '\E[0m'; } >&2
}

notice() {
  { printf '\E[33m'; echo ":: $1"; printf '\E[0m'; } >&2
}

if [ "$(id -u)" -ne 0 ]; then error "Please run as root." >&2; exit $E_NOTROOT; fi

case "$1" in
  install)
    info "Install sgs.bash-tweaks on $INSTALL_DIR"
    if [ -d "$INSTALL_DIR" ]; then
      echo "Already install. Try reinstall command"
      exit 0
    fi

    mkdir -p "$INSTALL_DIR"
    cp -r "${WORKING_DIR}/" "$INSTALL_PATH"

    if [[ -f /etc/nanorc ]]; then
      mv /etc/nanorc /etc/nanorc.old
      notice "Rename default *nanorc* to nanorc.old"
      ln -srf "${INSTALL_DIR}/other/nanorc" "/etc/nanorc"
      notice "Create shortcut for *nanorc* tweaks"
    fi

    for _profile in /home/*/.bashrc; do
      LINE=$(grep -n "${BASHRC_PATCH}" "$_profile" | awk -F':' '{print $1;}')
      if [[ -z $LINE ]]; then
        echo "${BASHRC_PATCH}" >> "$_profile"
        notice "PATCH *.bashrc* on $_profile"
      else
        error "The patch for *.bashrc* not present"
      fi
    done

    # special patch for root .bashrc file
    ROOT_LINE=$(grep -n "${BASHRC_PATCH}" "/root/.bashrc" | awk -F':' '{print $1;}')
    if [[ -z $ROOT_LINE ]]; then
      echo "${BASHRC_PATCH}" >> "/root/.bashrc"
      notice "SPECIAL PATCH FOR ROOT *.bashrc* on $_profile"
    else
      error "PATCH FOR ROOT *.bashrc* is present"
    fi

    source "$HOME"/.bashrc

    info "Shell Tweaks install complete!"
    info "Restart your terminal or source your .bashrc file to load new Shell Tweaks"
    ;;
  uninstall)
    info "Uninstall the bash tweaks"

    if [[ -f /etc/nanorc ]] && [[ -f /etc/nanorc.old ]]; then
      rm "/etc/nanorc"
      mv /etc/nanorc.old /etc/nanorc
      notice "Remove *nanorc* shortcut and restore default file"
    fi

    for _profile in /home/*/.bashrc; do
      LINE=$(grep -n "${BASHRC_PATCH}" "$_profile" | awk -F':' '{print $1;}')
      if [[ -n $LINE ]]; then
        sed -i -e "${LINE}d" "$_profile"
        notice "RESTORE PATCH *.bashrc* on $_profile"
      else
        error "No patch to remove from $_profile"
      fi
    done

    # REMOVE special patch for root .bashrc file
    ROOT_LINE=$(grep -n "${BASHRC_PATCH}" "/root/.bashrc" | awk -F':' '{print $1;}')
    if [[ -n $ROOT_LINE ]]; then
      sed -i -e "${ROOT_LINE}d" "/root/.bashrc"
      notice "REMOVE SPECIAL PATCH FOR ROOT *.bashrc* on $_profile"
    else
      error "REMOVE PATCH FOR ROOT *.bashrc* not present"
    fi

    if [[ -f /etc/profile.d/bash-tweaks.sh ]]; then
      rm "/etc/profile.d/bash-tweaks.sh"
      notice "Remove *bash-tweaks.sh file"
    fi

    [[ -d "$INSTALL_DIR" ]] && rm -rf "$INSTALL_DIR"


    source "$HOME"/.bashrc
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
#if [ -x "$(which virtualenv)" ]; then
#    export VIRTUALENVWRAPPER_PYTHON=$(which python)
#    export VIRTUALENVWRAPPER_VIRTUALENV=$(which virtualenv)
#    export WORKON_HOME=${PG_ZONE}/.virtualenvs
#    export PROJECT_HOME=${PG_ZONE}/apps
#    export VIRTUALENVWRAPPER_SCRIPT=/usr/share/virtualenvwrapper/virtualenvwrapper.sh
#    source /usr/share/virtualenvwrapper/virtualenvwrapper_lazy.sh
#fi
