#!/usr/bin/env bash
# testni, ze to ma prave dva parametre
if [[ ! $# -eq 2 ]]; then
    echo "Wrong usage." 1>&2
    exit 1
fi

NAME=${2}
# testni, ci subor existuje
if [[ ! -f ${LIST} ]]; then
    echo "File ${LIST} doesn't exist." 1>&2
    exit 1
fi
DEST=/home/apollo-4/Pictures/${NAME}
mkdir ${DEST}
NR=1
printf "Working "
while read -r LINK; do
    printf "."
    wget -q ${LINK} -O ${DEST}/${NR}.jpg
    NR=$((NR+1))
done < /home/apollo-4/bin/kral.vzduchu.txt
echo
zip -q ${NAME}.cbz ${DEST}/*
rm -rf ${DEST}
echo "Done"

