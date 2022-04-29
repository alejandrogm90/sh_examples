#! /b/bin/bash

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

read -p 'Directorio de origen: ' d1
if [ -d "$d1" ] ; then
	read -p 'Directorio de destino: ' d2
	if [ -d "$d2" ] ; then
		for lnn in `ls "$d1"` ; do
			if [ -f "$d1/$lnn" ] ; then
				echo cp "$d1/$lnn" "$d2"
			else
				echo "$d1/$lnn" "$d2/$lnn"
			fi
		done
	else
		echo "El directorio $d2 no existe."
	fi
else
	echo "El directorio $d1 no existe."
fi
ls "$d2"
