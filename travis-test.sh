#!/bin/bash -e

if [ -z "$NO_COVERAGE" -a "$(basename $TRAVIS_REPO_SLUG)" == "$ANGR_REPO" ]
then
	NOSE_OPTIONS="--with-coverage --cover-package=$ANGR_REPO --cover-erase"
fi
export NOSE_PROCESS_TIMEOUT=570
export NOSE_PROCESSES=2
export NOSE_OPTIONS="-v --nologcapture --with-timer $NOSE_OPTIONS"
bash -ex ./test.sh $ANGR_REPO

cd $ANGR_REPO
if [ "$(basename $TRAVIS_REPO_SLUG)" == "$ANGR_REPO" ]; then
	echo
	echo -e "\e[31m### Running linting for repository $ANGR_REPO\e[0m"
	../lint.py
fi
exit 0
