#!/usr/bin/env bash

#test suite setup
TESTDIR=testing
mkdir ${TESTDIR} && cd ${TESTDIR} || exit 1



# when new folder with existing name is going to be created then exit status is 1

# when new folder with existing name is going to be  created then error mesage is show

# test setup
DIR=dirx
mkdir ${DIR}
[[ $(mkdir ${DIR} 2>&1) = "mkdir: cannot create directory ‘${DIR}’: File exists" ]] || echo failed: when new folder with existing name is going to be created then error mesage is shown
#test teardown
rmdir ${DIR}


# when I create new folder then folder created
# when I create new folder then exit status is 0

#test setup
DIR=diry

mkdir ${DIR} && [[ -d ${DIR} ]] && [[ $(ls -a ${DIR} | wc -l ) -eq 2 ]]  || echo failed: when i create new folder then folder is crated
#test teardown
rmdir ${DIR}

#final test teardown
cd .. || rm -rf ${TESTDIR}


