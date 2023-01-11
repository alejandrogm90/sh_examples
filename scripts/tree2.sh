#!/bin/bash

# VARIABLES Y FUNCONES
DIR_HOME=$(cd `dirname $0` && pwd)
source "${DIR_HOME}/commonFunctions.sh"
SCRIPT_NAME=`getJustStriptName $0`

declare -A script_info
export script_info=(
	[name]="${SCRIPT_NAME}"
	[location]="${DIR_HOME}"
	[description]="Shows all tree"
	[calling]="./`getStriptName $0` "
)

showScriptInfo

if [ $# -eq 1 ] && [ -d $1 ] ; then
	find $1 -type d | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
else
	echo 'ERROR'
	echo $0' [directory]'
fi
