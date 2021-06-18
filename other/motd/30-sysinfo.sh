#!/bin/bash

neofetch_bin=$(which netfetch)
sensors_bin=$(which sensors)

#System load
LOAD1=$(cat /proc/loadavg | awk {'print $1'})
LOAD5=$(cat /proc/loadavg | awk {'print $2'})
LOAD15=$(cat /proc/loadavg | awk {'print $3'})

cpucores=$(cat /proc/cpuinfo | grep "model name" | wc -l)
[ "$cpucores" -eq "0" ] && cpucores=1
threshold="${cpucores:-1}.0"

function sysinfo() {
  USER=$(whoami)
  HOSTNAME=$(uname -n)
  IP=$(hostname -i)
  ROOT=$(df -Ph | grep root | awk '{print $4}' | tr -d '\n')
  HOME=$(df -Ph | grep home | awk '{print $4}' | tr -d '\n')
  BACKUP=$(df -Ph | grep backup | awk '{print $4}' | tr -d '\n')
  NUM_UNIQUE_USERS=$(users | tr ' ' '\n' | sort | uniq | wc -w)
  MEMORY=$(free -mh | grep "Mem" | awk '{print $2,"-",$3,"-",$4}')
  SWAP=$(free -mh | grep "Swap" | awk '{print $2,"-",$3,"-",$4}')
  PSA=$(ps -Afl | wc -l)

if [ "$sensors_bin" = 0 ]; then
    TEMPERATURE=$(sensors_bin | grep Core | awk {'print $3'} | xargs)
fi

  # time of day
  HOUR=$(date +"%H")
  if [ $HOUR -lt 12 -a $HOUR -ge 0 ]; then
    TIME="morning"
  elif [ $HOUR -lt 17 -a $HOUR -ge 12 ]; then
    TIME="afternoon"
  else
    TIME="evening"
  fi

  #System uptime
  uptime=$(cat /proc/uptime | cut -f1 -d.)
  upDays=$(expr $uptime / 60 / 60 / 24)
  upHours=$(expr $uptime / 60 / 60 % 24)
  upMins=$(expr $uptime / 60 % 60)
  upSecs=$(expr $uptime % 60)

  cpuname=$(cat /proc/cpuinfo | grep -m 1 "model name" | awk -F ": " '{print $2}')

  # \033[0;34m+     \033[0;37mCPU usage \033[0;34m= \033[1;32m$cpuusage%

  echo -e "
  \033[0;34m+++++++++++++++++: \033[0;37mSystem Data\033[0;34m :+++++++++++++++++++++++++++++
  \033[0;34m+ \033[0;37mDate and Time \033[0;34m= \033[1;32m$(date)
  \033[0;34m+         \033[0;37mUsers \033[0;34m= \033[1;32mCurrently $NUM_UNIQUE_USERS DIFFERENT user(s) logged on
  \033[0;34m+  \033[0;37mCurrent user \033[0;34m= \033[1;32m$USER
  \033[0;34m+      \033[0;37mHostname \033[0;34m= \033[1;32m$HOSTNAME
  \033[0;34m+    \033[0;37mIP Address \033[0;34m= \033[1;32m$IP
  \033[0;34m+        \033[0;37mUptime \033[0;34m= \033[1;32m$upDays days $upHours hours $upMins minutes $upSecs seconds
  \033[0;34m+          \033[0;37mLoad \033[0;34m= \033[1;32m$LOAD1 - $LOAD5 - $LOAD15 (1-5-15 min)
  \033[0;34m+     \033[0;37mCPU model \033[0;34m= \033[1;32m$cpucores x $cpuname
  \033[0;34m+        \033[0;37mMemory \033[0;34m= \033[1;32m$MEMORY (total-free-available)
  \033[0;34m+   \033[0;37mSwap in use \033[0;34m= \033[1;32m$SWAP (total-used-free) MB
  \033[0;34m+           \033[0;37mHDD \033[0;34m= \033[1;32mUsed $(df -h / | tail -n 1 | awk {'print $3'}) out of $(df -h / | tail -n 1 | awk {'print $2'})
  \033[0;34m+     \033[0;37mProcesses \033[0;34m= \033[1;32m$PSA running
  \033[0;34m+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\033[0;37m
  "
}

if [ $(echo "$LOAD1 < $threshold" | bc ) -eq 1 ]; then
  if [ "$neofetch_bin" = 0 ]; then
    neofetch_bin
  else
    sysinfo
  fi
else
  echo
  echo " System information disabled due to load higher than $threshold"
fi
