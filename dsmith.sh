#!/bin/bash

function die {
    >&2 echo "$1"
    exit "$2"
}

git branch -D dsmith
git checkout -b dsmith || die "failed to create dsmith" 1
touch dsmith.txt
git add dsmith.txt
git commit -m "adding dsmith.txt"
