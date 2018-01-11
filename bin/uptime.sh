#!/bin/bash 

DATE=$(date +%T)
uptime=$(</proc/uptime)
uptime=${uptime%%.*}


days=$(( uptime/60/60/24 ))
hours=$(( uptime/60/60%24 ))
minutes=$(( uptime/60%60 ))
seconds=$(( uptime%60 ))





echo "$days days, $hours hours, $minutes minutes, $seconds seconds"

