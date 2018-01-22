#!/usr/bin/env bash


DEST="/home/apollo-4/Pictures/budapest/"
NR=$(ls ${DEST}budapest-*.jpg 2> /dev/null | wc -l)
NR=$((NR + 1))


wget -q -O "${DEST}budapest-${NR}.jpg" "http://camera.victoria.hu/axis-cgi/jpg/image.cgi?resolution=4CIF"


