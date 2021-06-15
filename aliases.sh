#!/bin/bash

# alias to show the date
alias da='date "+%Y-%m-%d %A %T %Z"'

## Alias's to modified commands

# Filesystem
alias home='cd ~'
alias cd..='cd ..'
alias ..='cd ..'                # Go up one directory
alias ...='cd ../..'            # Go up two directories
alias ....='cd ../../..'        # Go up 3 directories
alias .....='cd ../../../..'    # Go up 4 directories

# cd into the old directory
alias bd='cd "$OLDPWD"'

# Remove a directory and all files
alias rmd='/bin/rm  --recursive --force '

# Alias's for multiple directory listing commands
alias la='ls -Alh'                    # show hidden files
alias ls='ls -Fh --color=always'      # add colors and file type extensions
alias lx='ls -lXBh'                   # sort by extension
alias lk='ls -lSrh'                   # sort by size
alias lc='ls -lcrh'                   # sort by change time
alias lu='ls -lurh'                   # sort by access time
alias lr='ls -lRh'                    # recursive ls
alias lm='ls -alh |more'              # pipe through 'more'
alias lw='ls -xAh'                    # wide listing format
alias ll='ls -Fls'                    # long listing format
alias labc='ls -lap'                  # alphabetical sort
alias lf="ls -l | egrep -v '^d'"      # files only
alias ldir="ls -l | egrep '^d'"       # directories only

# alias chmod commands
alias mx='chmod a+x'
alias 000='chmod -R 000'
alias 644='chmod -R 644'
alias 666='chmod -R 666'
alias 755='chmod -R 755'
alias 777='chmod -R 777'

# Search command line history
alias h="history | grep "

# Search running processes
alias p="ps aux | grep "
alias topcpu="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"

# Search files in the current folder
alias f="find . | grep "

# Count all files (recursively) in the current folder
alias countfiles="for t in files links directories; do echo \`find . -type \${t:0:1} | wc -l\` \$t; done 2> /dev/null"

# To see if a command is aliased, a file, or a built-in command
alias checkcommand="type -t"

# Show current network connections to the server
alias ipview="netstat -anpl | grep :80 | awk {'print \$5'} | cut -d\":\" -f1 | sort | uniq -c | sort -n | sed -e 's/^ *//' -e 's/ *\$//'"

# Show open ports
alias openports='netstat -nape --inet'

# Alias's for safe and forced reboots
alias rebootsafe='sudo shutdown -r now'
alias rebootforce='sudo shutdown -r -n now'

alias tree='tree -a -f -C -p'          # display directory in tree format using -a all files, -f full path, Turn colorization on always, -p Print the protections for each file
#alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"

# system info
alias psi='ps h -eo pmem,comm | sort -nr | head'
alias cpuu="ps -e -o pcpu,cpu,nice,state,cputime,args --sort pcpu | sed '/^ 0.0 /d'"
alias memu='ps -e -o rss=,args= | sort -b -k1,1n | pr -TW$COLUMNS'

# Helpers
alias grep='grep --color=auto'      # Always highlight grep search term
alias ping5='ping -c 5'             # Pings with 5 packets, not unlimited
alias df='df -h'                    # Disk free, in gigabytes, not bytes
alias du='du -h -c'                 # Calculate total disk usage for a folder

#alias clj='clj-env-dir'            # Clojure helper
alias clr='clear;echo "Currently logged in on $(tty), as $(whoami) in directory $(pwd)."'
#alias tt='tt++ $HOME/.ttconf'

#alias emc="emacsclient -n" # no blocking terminal waiting for edit

#Ruby
#alias sgi='sudo gem install' # Install ruby stuff
#alias be='bundle exec'             # shortcut for ruby environment activation

# Docker
#alias dc='docker-compose'    # invoke docker-compose, which takes too long to type.

# Tweak vim
alias svim="sudo vim" # Run vim as super user

# Tweak nano editor
alias nano="nano --smooth --linenumbers --morespace --showcursor"
alias snano="sudo nano" #Run nano as super user

# Nifty extras
alias servethis="python -c 'import SimpleHTTPServer; SimpleHTTPServer.test()'"
alias pypath='python -c "import sys; print sys.path" | tr "," "\n" | grep -v "egg"'
alias pycclean='find . -name "*.pyc" -exec rm {} \; && find . -name "__pycache__" -exec rm -rf {} \;'
#alias ssh='ssh -R 10999:localhost:22'
#alias nethack='telnet nethack.alt.org'

# GIT ALIASES
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

# HG ALIASES
#alias hgst='hg status'
#alias hgd='hg diff | $GIT_EDITOR -'
#alias hgo='hg outgoing'

# Download apps tweeaks
alias wget='wget -c -t 0 --timeout=20 --waitretry=20'

# Python Twine
alias twineTest='twine upload --repository pypitest $(pwd)/dist/*'
alias buildPyWheel='python3 setup.py bdist_wheel'
