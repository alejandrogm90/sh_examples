#!/bin/bash

# VARIABLES AND FUNCTIONS
DIR_HOME=$(cd `dirname $0` && pwd)
source "${DIR_HOME}/commonFunctions.sh"
SCRIPT_NAME=`getJustStriptName $0`
#export LOG_FILE="${SCRIPT_NAME}_`date +%F`.log"

declare -A script_info
export script_info=(
	[name]="${SCRIPT_NAME}" 
	[location]="${DIR_HOME}" 
	[description]="My large description" 
	[calling]="./`getStriptName $0`"
)

showScriptInfo

# ANTES DE EMPEZAR
if [ $# -ne 1 ] ; then 
	showError 1 "$0 [FILE OR DIRECTORY]"
else
	if [[ ! -f "$1" && ! -d "$1" ]] ; then
		showError 2 "File or directory not exist"
	else
		nomFichGenerado="${1}_`date +%F`_backup.tar"
		tar -rvf "$nomFichGenerado" "$1"
		gzip -v9 "$nomFichGenerado"
	fi
fi
