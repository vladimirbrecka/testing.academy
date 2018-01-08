#!/bin/bash


if [ $# -gt 1 ]; then
    echo "zly pocet parametrov " 1>&2
    exit 1
 fi
if [ $# -eq 1 ]; then
    HOUR=$1
 else
    
    HOUR=$(date +%k)

read -p "kolko je hodin, $USER ?" HOUR
fi

if [ $HOUR -lt 8 ] ; then
    echo "dobre rano $USER "

    elif [ $HOUR -lt 18 ]; then
         echo " dobry den $USER "
    else
        echo "dobry vecer $USER "
  
fi




