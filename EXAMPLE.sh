#!/bin/bash

# VARIABLES Y FUNCONES
DIR_HOME=$(cd `dirname $0` && pwd)
source "${DIR_HOME}/scripts/commonFunctions.sh"
SCRIPT_NAME=`getJustStriptName $0`
export LOG_FILE="current_log"

declare -A script_info
export script_info=(
	[name]="${SCRIPT_NAME}" 
	[location]="${DIR_HOME}" 
	[description]="My large description" 
	[calling]="./`getStriptName $0` yyyymmdd"
)

showScriptInfo

if [ $# -eq 1 ]; then 
    extractDate $1
else  
    showError 1 "$(date -u) [ERROR]: Number of incorrect parameters.Must be 1 date"
fi 

echo "The date passed as parameter whas: $ODATE"
echo "The date passed as parameter transformed whas: $FECGUI"

# Write an error in a LOG_FILE
showError 0 "My error test check"