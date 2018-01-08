#!/bin/bash

HOUR=$(date +%H)



if [ $HOUR -ge 0 ] && [ $HOUR -le 8 ]; then
            echo "Dobre rano $USER je $HOUR hodin"
                else
                    if [ $HOUR -gt 8 ] && [ $HOUR -le 12 ] ; then
                        echo "Dobry den $USER je $HOUR "
                        else
                        if [ $HOUR -gt 12 ] && [ $HOUR -lt 24 ]; then
                            echo "Dobry vecer $USER"
                        fi
                    fi
fi

echo "$HOUR"


