#!/bin/bash

# VARIABLES Y FUNCONES
DIR_HOME=$(cd `dirname $0` && pwd)
source "${DIR_HOME}/commonFunctions.sh"
SCRIPT_NAME=`getJustStriptName $0`

declare -A script_info
export script_info=(
	[name]="${SCRIPT_NAME}"
	[location]="${DIR_HOME}"
	[description]="A example of WAIT COMMAND usage"
	[calling]="./`getStriptName $0` "
)

showScriptInfo

sleep 2 &
process_id=$!
echo "PID: $process_id"
wait $process_id
echo "Exit status: $?"

sleep 4 &
sleep 10 &
sleep 6 &
wait -n
echo "First job completed."
wait
echo "All jobs completed."
