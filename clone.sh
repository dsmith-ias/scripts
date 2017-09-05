#!/bin/bash

function usage {
	echo "${0} repository"
	exit 1
}

function die {
	echo "$1"
	exit "$2"
}

repository=$1

[[ -z "${repository}" ]] && usage

dsmith_url="git@github.com:dsmith-ias/${repository}.git"
ias_url="git@github.com:integralads/${repository}.git"

git clone "${dsmith_url}" || die "failed to clone ${dsmith_url}" 1
cd "${repository}"
git remote add integral "${ias_url}"
git fetch integral

for branch in master release hotfix develop; do
	git checkout "${branch}"

	if [ $? -ne 0 ]; then
		git checkout "integral/${branch}" || continue
		git checkout -b "${branch}"
	fi

	git branch -u "integral/${branch}"
	git reset --hard "integral/${branch}"
	git pull
done
