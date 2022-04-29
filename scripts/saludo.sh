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
	[calling]="./`getStriptName $0` "
)

showScriptInfo

# sudo apt install figlet cowsay fortune fortunes-es fortunes-es-off

vacas=(`ls /usr/share/cowsay/cows`)
TVACAS=${#vacas[*]}
NVACA=$((RANDOM%$TVACAS))
vaca=${vacas[$NVACA]}
figlet Alex Mola y Lo sabes
fortune | cowsay -f $vaca
