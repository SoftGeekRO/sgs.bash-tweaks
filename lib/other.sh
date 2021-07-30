#!/usr/bin/env bash

# bash completion settings
#bind "set completion-ignore-case on" # This ignores case in bash completion
#bind "set bell-style none" # Turn off bell
#bind "set show-all-if-ambiguous On" # Single tab completion
#bind Space:magic-space #auto expand ! variants upon space

SHOPT=$(which shopt)
if [ -z "${SHOPT}" ]; then
  shopt -s histappend        # Append history instead of overwriting
  shopt -s cdspell           # Correct minor spelling errors in cd command
  shopt -s dotglob           # includes dotfiles in pathname expansion
  shopt -s checkwinsize      # If window size changes, redraw contents
  shopt -s cmdhist           # Multiline commands are a single command in history.
  shopt -s extglob           # Allows basic regexps in bash.
  shopt -s nocaseglob        # Case-insensitive globbing (used in pathname expansion)
fi
