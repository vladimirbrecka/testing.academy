#!/bin/bash

echo $0
echo $1
echo $2
echo $3
echo $@
echo $#

read -p "kolko je hodin, $USER ?" HOUR
$1=$(date +%k)

if [ $HOUR -lt 8 ] ; then
    echo "dobre rano $USER "

    elif [ $HOUR -lt 18 ]; then
         echo " dobry den $USER "
    else
        echo "dobry vecer $USER "
  
fi




