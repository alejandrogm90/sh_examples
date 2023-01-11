#!/bin/bash

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

temDatos="/tmp/miCPU-tem"
lscpu > "$temDatos"
for linea in 1 2 3 4 10 13 ; do
	echo "`awk NR==$linea $temDatos`"
done
echo ''
