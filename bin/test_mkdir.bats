#!/usr/bin/env bats


@test "1. when new folder with existing name is going to be created then error mesage is shown" {
    # setup
    DIR=dirx
    mkdir ${DIR}

    [[ $(mkdir ${DIR} 2>&1) = "mkdir: cannot create directory ‘${DIR}’: File exists" ]]
    
    #teardown
    rmdir ${DIR}
} 
@test "2. when i create new folder then folder is crated" {

    # setup
    DIR=diry

    mkdir ${DIR} &&  [[ -d ${DIR} ]]

    #teardown
    rmdir ${DIR}
}
@test "3. when new folder created then it is empty" {

    # setup
    DIR=dirz
    mkdir ${DIR} && [[ $(ls -a ${DIR} | wc -l ) -eq 2 ]]

    #teardown
    rmdir ${DIR}
}
@test "4. when i didnt set name of folder then report" {
    
    # setup
    mkdir || [[ $(mkdir 2>&1) = "mkdir: missing operand
Try 'mkdir --help' for more information." ]]
}
@test "5. when not allowed character set then error" {
    # setup
    DIR=!@#*/;\
    mkdir ${DIR} || [[ $(mkdir 2>&1) = "bash: !@#: event not found" ]]
    #teardown
    rmdir ${DIR}
}

@test "6. when path not exist then error" {
    # setup
    DIR="/home/apollo4/Pictures/bin/"
    mkdir ${DIR} && [[ $(mkdir 2>&1) = "mkdir: cannot create directory ‘${DIR}’: No such file or directory" ]]
}

@test "7. when name of folder is too long then error" {
    # setup
    DIR=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
    mkdir ${DIR} && [[ $(mkdir 2>&1) = "mkdir: cannot create directory ‘${DIR}’: File name too long" ]]
}
#@test "8. when unknown option is given, then error message is shown" {
    # setup
