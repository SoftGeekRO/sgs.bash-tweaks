#!/bin/bash

# Alias's to modified commands

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -iv'
alias mkdir='mkdir -p'
# sort by cpu usage
alias top='top -o %CPU'
alias ps='ps auxf'
# Pings with 5 packets, not unlimited
alias ping5='ping -c 5'
alias less='less -R'
# Always highlight grep search term
alias grep='grep --color=auto'
# Disk free, in gigabytes, not bytes
alias df='df -h'
# Calculate total disk usage for a folder
alias du='du -h -c'
alias cls='clear'
alias multitail='multitail --no-repeat -c'
alias freshclam='sudo freshclam'
alias vi='vim'
alias svi='sudo vi'
alias vis='vim "+set si"'

# Download apps tweeaks
alias wget='wget -c -t 0 --timeout=20 --waitretry=20'

# Go directly to root folder
alias home='cd ~'
alias cd..='cd ..'
# Go up one directory
alias ..='cd ..'
# Go up two directories
alias ...='cd ../..'
# Go up 3 directories
alias ....='cd ../../..'
# Go up 4 directories
alias .....='cd ../../../..'

# cd into the old directory
alias bd='cd "$OLDPWD"'

# Remove a directory and all files
alias rmd='/bin/rm  --recursive --force '

#Run nano as super user
alias snano="sudo nano"

# Alias's for multiple directory listing commands

# show hidden files
alias la='ls -Alh'
# add colors and file type extensions
alias ls='ls -Fh --color=auto'
# sort by extension
alias lx='ls -lXBh'
# sort by size
alias lk='ls -lSrh'
# sort by change time
alias lc='ls -lcrh'
# sort by access time
alias lu='ls -lurh'
# recursive ls
alias lr='ls -lRh'
# pipe through 'more'
alias lm='ls -alh |more'
# wide listing format
alias lw='ls -xAh'
# long listing format
alias ll='ls -Fls'
# alphabetical sort
alias labc='ls -lap'
# files only
alias lf="ls -l | egrep -v '^d'"
# directories only
alias ldir="ls -l | egrep '^d'"
# on a GNU system
# displays the size of each item,
# and then sorts it by size, in a single column,
# with a notation to indicate the kind of file
alias lt='ls --human-readable --size -1 -S --classify'

# alias chmod commands
alias mx='chmod a+x'
alias 000='chmod -R 000'
alias 644='chmod -R 644'
alias 666='chmod -R 666'
alias 755='chmod -R 755'
alias 777='chmod -R 777'
