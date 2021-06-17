#!/usr/bin/env bash

lscolor_data_dir="$HOME/.shell_tweaks/other"

######################
##  COMMAND PROMPT ###
######################
PROMPT_COMMAND='history -a'

#################
##  LESS ENVS ###
#################
# Color for manpages in less makes manpages a little easier to read
export LESSOPEN="| $HOME/.shell_tweaks/plugins/src-hilite-lesspipe.sh %s"
export LESS="-R"

export LESSHISTFILE=/dev/null
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;37m'

#############################
##  BASH HISTORY SETTINGS ###
#############################
export HISTTIMEFORMAT="%m-%d-%Y %H:%M:%S "
export HISTCONTROL=erasedups  # Ignore duplicate entries in history
export HISTFILE=~/.histfile
export HISTSIZE=10000         # Increases size of history
export SAVEHIST=10000
export HISTIGNORE="&:ls:ll:la:l.:pwd:cd:..:...:exit:clear:clr:[bf]g:history"

#############################
##         COLORS         ###
#############################
# To have colors for ls and all grep commands such as grep, egrep and zgrep
export CLICOLOR=1
eval "$(dircolors -b "$lscolor_data_dir"/LS_COLORS)"

export GREP_COLORS='sl=48;5;233;97:cx=40;37:mt=48;5;186;30:fn=49;38;5;197:ln=49;38;5;154:bn=49;38;5;141:se=49;38;5;81';

# for common 256 color terminals (e.g. gnome-terminal)
export TERM=xterm-256color
