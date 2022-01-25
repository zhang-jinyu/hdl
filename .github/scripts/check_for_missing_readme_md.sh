#!/bin/sh
#
# Ensure there are Readme.md files in all the project directories
#

MISSING=$(find projects/ -mindepth 1 -maxdepth 1 \( -path projects/common -o -path projects/scripts \) -prune -o -type d '!' -exec test -e "{}/Readme.md" ';' -print)
if [ "$(echo ${MISSING} | wc -c)" -gt "1" ] ; then
	echo Missing Readme.md files in the ${MISSING}
	exit 1
fi
