#!/bin/bash

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
#alias cd="venv_cd"
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

# tmux settings
alias tmux='TERM=xterm-256color \tmux'

alias clr='clear;echo "Currently logged in on $(tty), as $(whoami) in directory $(pwd)."'

####################
### SYSTEM INFO ####
####################
alias psi='ps h -eo pmem,comm | sort -nr | head'
alias cpuu="ps -e -o pcpu,cpu,nice,state,cputime,args --sort pcpu | sed '/^ 0.0 /d'"
alias memu='ps -e -o rss=,args= | sort -b -k1,1n | pr -TW$COLUMNS'

# Alias's for safe and forced reboots
alias off="sudo shutdown -h now"
alias rebootsafe='sudo shutdown -r now'
alias rebootforce='sudo shutdown -r -n now'

# Search command line history
alias h="history | grep "

# Search running processes
alias p="ps aux | grep "
alias topcpu="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"

# Search files in the current folder
alias f="find . | grep "

# To see if a command is aliased, a file, or a built-in command
alias checkcommand="type -t"

# Show open ports
alias openports='netstat -nape --inet'

####################
### GIT ALIASES ####
####################
alias g=git
alias ga='git add'
alias gb='git branch'
alias gba='git branch -a'
alias gc='git commit -v'
alias gl='git pull'
alias gp='git push'
alias gst='git status -sb'
alias gsd='git svn dcommit'
alias gsr='git svn rebase'
alias gs='git stash'
alias gsa='git stash apply'
alias gr='git stash && git svn rebase && git svn dcommit && git stash pop' # git refresh
alias gd='git diff | $GIT_EDITOR -'
alias gmv='git mv'
alias gho='$(git remote -v 2> /dev/null | grep github | sed -e "s/.*git\:\/\/\([a-z]\.\)*/\1/" -e "s/\.git.*//g" -e "s/.*@\(.*\)$/\1/g" | tr ":" "/" | tr -d "\011" | sed -e "s/^/open http:\/\//g" | uniq)'

####################
### Python extra ###
####################

# Python Twine
alias twineTest='twine upload --repository pypitest $(pwd)/dist/*'
alias buildPyWheel='python3 setup.py bdist_wheel'

# Nifty extras
alias servethis="python -c 'import SimpleHTTPServer; SimpleHTTPServer.test()'"
alias pypath='python -c "import sys; print sys.path" | tr "," "\n" | grep -v "egg"'
alias pycclean='find . -name "*.pyc" -exec rm {} \; && find . -name "__pycache__" -exec rm -rf {} \;'

# curl for useragents
alias iecurl="curl -H \"User-Agent: Mozilla/5.0 (Windows; U; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)\""
alias ffcurl="curl -H \"User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.8) Gecko/2009032609 Firefox/3.0.0 (.NET CLR 3.5.30729)\""

