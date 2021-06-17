#!/bin/bash


alias clr='clear;echo "Currently logged in on $(tty), as $(whoami) in directory $(pwd)."'

# system info
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
### Python extra ###
####################

# Python Twine
alias twineTest='twine upload --repository pypitest $(pwd)/dist/*'
alias buildPyWheel='python3 setup.py bdist_wheel'

# Nifty extras
alias servethis="python -c 'import SimpleHTTPServer; SimpleHTTPServer.test()'"
alias pypath='python -c "import sys; print sys.path" | tr "," "\n" | grep -v "egg"'
alias pycclean='find . -name "*.pyc" -exec rm {} \; && find . -name "__pycache__" -exec rm -rf {} \;'
