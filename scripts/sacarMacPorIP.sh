#! /bin/bash

# VARIABLES Y FUNCONES
DIR_HOME=$(cd `dirname $0` && pwd)
source "${DIR_HOME}/commonFunctions.sh"
SCRIPT_NAME=`getJustStriptName $0`

declare -A script_info
export script_info=(
	[name]="${SCRIPT_NAME}" 
	[location]="${DIR_HOME}" 
	[description]="My large description" 
	[calling]="./`getStriptName $0` "
)

showScriptInfo

if [ $# -eq 1 ] ; then
	sudo arping -fI wlp5s0b1 $1 | grep "]" | cut -d'[' -f2 | cut -d']' -f1
else
	echo 'ERROR:'
	echo $0' [IP]'
fi
