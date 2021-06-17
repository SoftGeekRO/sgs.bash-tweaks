#!/usr/bin/env bash

# bash completion settings
bind "set completion-ignore-case on" # This ignores case in bash completion
bind "set bell-style none" # Turn off bell
bind "set show-all-if-ambiguous On" # Single tab completion
bind Space:magic-space #auto expand ! variants upon space

# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize

# correct small spelling errors automagically
shopt -s cdspell

# write to a shared history file for all shells
shopt -s histappend

# Enable advanced pattern matching.
shopt -s extglob

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# For considering dot files (turn on dot files)
shopt -s dotglob
