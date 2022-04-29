#!/bin/bash

# VARIABLES Y FUNCONES
DIR_HOME=$(cd `dirname $0` && pwd)
source "${DIR_HOME}/commonFunctions.sh"
SCRIPT_NAME=`getStriptNameWithoutExtension $0`

declare -A script_info
export script_info=(
	[name]="${SCRIPT_NAME}" 
	[location]="${DIR_HOME}" 
	[description]="My large description" 
	[calling]="./`getStriptName $0` DIR FILE"
)

showScriptInfo

dir1="${DIR_HOME}"
dir2=""
texto1=""
numF=0
numA=0

if [ -d "$dir1" ] ; then
	dir2=(`ls $dir1`)
	echo $dir2
	numF=${#dir2[*]}
	numA=$numF
	for f1 in `ls $dir1`; do
		dir2="$dir1/$f1"
		echo $dir2
		cat $dir2
		texto1=$texto1'#'
		numA=$(( $numA - 1 ))
		echo 'Progress '$texto1' [ %'$(( 100 - (($numA * 100) / $numF) ))' ]'
		sleep 1
	done
else
	echo "No existe "$dir1
fi
