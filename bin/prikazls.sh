#!/usr/bin/env bash

data=$(printf '%s\n' .* *)

for entry in ${data}
do
    echo ${entry}
done

