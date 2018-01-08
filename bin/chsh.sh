#!/bin/bash


echo "Changing shell for $USER"
echo "New shell [ ${SHELL} ]:" 

read NEWSHELL
# ak pouzival nic nezada, tak koniec

if [ -z ${NEWSHELL} ]; then 
    exit 0
fi

#ak pouzivatel nezada absolutnu cestu

if [ ! ${NEWSHELL} =~ ^/.+ ]; then 
    echo "chsh.sh: shell must be a full path name" 1>&2
    exit 1
fi

# ak subor neexistuje 

if [ ! -f ${NEWSHELL} ]; then 
    echo "chsh.sh: \"${NEWSHELL}\" does not exist " 1>&2
    exit 1
fi

#ak nieje spustitelny

if [ ! -x ${NEWSHELL} ]; then
    echo  "chsh.sh: \"${NEWSHELL}\" is not executable" 1>&2
    exit 1
fi

# ak sa cesta nenachadza v /etc/shells

egrep "^${NEWSHELL}" /etc/shells > /dev/null 2>&1 

if [ $? -eq 1 ]; then
    echo "chsh.sh:\"${NEWSHELL}\" is not listed in /etc/shells " 1>&2
    exit 1
fi

# aktualizujem /etc/passwd








    

