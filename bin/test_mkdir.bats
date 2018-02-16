#!/usr/bin/env bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

setup() {
    export DIR=$(mktemp -du)
}

teardown() {
    rm -rf "$DIR"
}

@test "1. when new folder with existing name is going to be created then error mesage is shown" {
   
   mkdir "$DIR"
   run mkdir "$DIR"
   assert_equal "$output" "mkdir: cannot create directory ‘$DIR’: File exists"
} 


@test "2. when folder with existing name is going to be created, hen exit with status 1" {

    mkdir "$DIR"
    run mkdir "$DIR"
    assert_equal "$status" 1
}


@test "3. when new folder created then it is empty" {

    # setup
    DIR=dirz
    mkdir ${DIR} && [[ $(ls -a ${DIR} | wc -l ) -eq 2 ]]

    #teardown
    rmdir ${DIR}
}

@test "4. when i didnt set name of folder then report" {
    run mkdir
    assert_equal "$output" "mkdir: missing operand
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
    DIR="/home/apollo4/Pictures/bin/"
    run mkdir $DIR
    assert_equal "$output" "mkdir: cannot create directory ‘$DIR’: No such file or directory"
}

@test "7. when name of folder is too long then error" {
    dir=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
    run mkdir $dir
    assert_equal "$output" "mkdir: cannot create directory ‘$dir’: File name too long"
}

@test "8. when unknown option is given, then error message is shown" {
    run mkdir -x
    assert_equal "$output" "mkdir: invalid option -- 'x'
Try 'mkdir --help' for more information." 
}
