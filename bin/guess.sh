#!/bin/bash

ODPOVED=y
while [[ $ODPOVED =~ ^(y|yes|Y|YES|a|A|ANO)$ ]]; do
echo "Myslim si cilo od 1 do 20"


SECRET=$(( ( RANDOM % 20 ) + 1 ))
TIP=0
ATTEMPTS=5


while [ $TIP -ne $SECRET ] && [ $ATTEMPTS -gt 0 ] ; do
    read -p "Tvoj tip: " TIP

    while [[ ! -n $TIP ]] || [[ ! $TIP =~ ^[0-9]+$ ]] || [[ ! $TIP -ge 1 ]] || [[ ! $TIP -le 20 ]]; do  
        echo "Ta ty co si zac ? Zadaj cislo"
        read TIP
    
    done

    if [ $TIP -gt $SECRET ]; then 
        echo "moje cislo je mensie ako $TIP"
    else 
        if [ $TIP -lt $SECRET ]; then
            echo "moje cislo je vacsie ako $TIP"
        else
            echo "ta ty si genius"
        fi
    fi
    ATTEMPTS=$[ $ATTEMPTS-1 ]; 
        echo "Pocet zostavajucich pokusov $ATTEMPTS"
        

done 

if [ $TIP -ne $SECRET ]; then
    echo "uz ti dosli pokusy"
fi

read -p "Ak chces pokracovat stlac y/n " ODPOVED 

    if [ $ODPOVED = "n" ]; then
       echo "Dakujem za Hru"
    fi
   
done
