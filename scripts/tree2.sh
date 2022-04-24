#!/bin/bash

if [ $# -eq 1 ] && [ -d $1 ] ; then
	find $1 -type d | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
else
	echo 'ERROR'
	echo $0' [directory]'
fi
