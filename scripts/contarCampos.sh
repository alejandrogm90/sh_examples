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

function numCoincidencias() {
    fileName=$1
    shift 1
    numTotal=0
    for elemento in $* ; do 
        if [ "`cat $fileName | grep $elemento`" != "" ] ; then
            numTotal=$(( $numTotal + 1 ))
        fi
    done
    echo $numTotal
}

if [ $# -eq 2 ]; then 
    if [ -d "$1" ] ; then
        START_DIR="$1"
        ELEMENTOS=`cat $2`
        echo "ELEMENTOS: "$ELEMENTOS
        echo "TOTAL DE ELEMENTOS: "`echo $ELEMENTOS | wc -w`
        for csvFile in `ls $START_DIR/*.csv` ; do 
            echo "$csvFile "`numCoincidencias $csvFile $ELEMENTOS` 
        done
    else 
        echo "$1 no es un directorio o no existe." 
    fi
else  
    showError 1 "$(date -u) [ERROR]: Number of incorrect parameters.Must be 1 date"
fi 
