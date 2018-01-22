#!/usr/bin/env bash

DATAFILE=~/Documents/monitoring.csv

# get data
TIMESTAMP=$(date +"%Y%m%dT%H:%M")
UPTIME=$(cut -f1 -d" " /proc/uptime)
AVG=$(cut -f1 -d" " /proc/loadavg)
TEMP=$(sensors | egrep "Core 0" | awk '{print $3}')
RX=$(ifconfig enp12s0 |grep bytes|egrep "RX"|awk '{print $5}')
TX=$(ifconfig enp12s0 |grep bytes|egrep "TX"|awk '{print $5}')
HOME=$(df | egrep "/home$" | awk '{print $4}')


# append data to file
echo "${TIMESTAMP};${UPTIME};${AVG};${TEMP};${RX};${TX};${HOME}" >> ${DATAFILE}

