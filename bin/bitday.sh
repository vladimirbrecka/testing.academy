#!/bin/bash


HOUR=$(date +%k)


if [ $HOUR -ge 0 ] && [ $HOUR -lt 2 ]; then
    YY=1

    elif [ $HOUR -ge 2 ] && [ $HOUR -lt 4 ]; then
        YY=2

    elif [ $HOUR -ge 4 ] && [ $HOUR -lt 6 ]; then
        YY=3

    elif [ $HOUR -ge 6 ] && [ $HOUR -lt 8 ]; then
        YY=4

    elif [ $HOUR -ge 8 ] && [ $HOUR -lt 10 ]; then 
        YY=5

    elif [ $HOUR -ge 10 ] && [ $HOUR -lt 12 ]; then
        YY=6

    elif [ $HOUR -ge 12 ] && [ $HOUR -lt 14 ]; then
        YY=7

    elif [ $HOUR -ge 14 ] && [ $HOUR -lt 16 ]; then
        YY=8

    elif [ $HOUR -ge 16 ] && [ $HOUR -lt 18 ]; then
        YY=9

    elif [ $HOUR -ge 18 ] && [ $HOUR -lt 20 ]; then
        YY=10

    elif [ $HOUR -ge 20 ] && [ $HOUR -lt 22 ]; then
        YY=11

    elif [ $HOUR -ge 22 ] && [ $HOUR -lt 0 ]; then
        YY=12
 fi

echo "/home/apollo-4/Pictures/bitday/bitday$YY.png" 


gsettings set org.gnome.desktop.background picture-uri "/home/apollo-4/Pictures/bitday/bitday$YY.png"

