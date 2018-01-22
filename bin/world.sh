#!/usr/bin/env bash


DEST="/home/apollo-4/Pictures/world/"
NR=$(ls ${DEST}world-*.jpg 2> /dev/null | wc -l)
NR=$((NR + 1))
wget -q -O "${DEST}world-${NR}.jpg" "http://www.opentopia.com/images/cams/world_sunlight_map_rectangular.jpg"



