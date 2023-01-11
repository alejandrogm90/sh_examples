#! /bin/bash

# VARIABLES Y FUNCONES
DIR_HOME=$(cd `dirname $0` && pwd)
source "${DIR_HOME}/commonFunctions.sh"
SCRIPT_NAME=`getJustStriptName $0`

declare -A script_info
export script_info=(
	[name]="${SCRIPT_NAME}"
	[location]="${DIR_HOME}"
	[description]="A example of date types usage"
	[calling]="./`getStriptName $0` "
)

showScriptInfo

HOY=$(date +%Y/%m/%d)
AYER=$(date --date "yesterday" +%Y/%m/%d)
MANA=$(date --date "tomorrow" +%Y/%m/%d)
echo 'TODOS los datos por separado: '`date +%Y`'-'`date +%m`'-'`date +%d`' '`date +%T`
echo 'La fecha en segundos desde 1970-01-01 00:00:00 UTC es: '`date +%s`
echo "Ayer fue : $AYER"
echo "Hoy es : $HOY"
echo "Mañana será : $MANA"

