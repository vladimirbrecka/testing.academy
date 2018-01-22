#!/usr/bin/env bash


DEST="/home/apollo-4/Pictures/komix/"
NR=$(ls ${DEST}komix-${NR}.jpg | wc -l)



while read -r LINE ; do
    echo "stahujem $LINE"



wget -q -O "${DEST}komix-${NR}.jpg" "$LINE"
NR=$((NR + 1))

done < /home/apollo-4/bin/comix.links.txt

zip -r komix.cbz /home/apollo-4/Pictures/komix


