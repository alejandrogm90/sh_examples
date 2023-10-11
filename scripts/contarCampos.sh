#!/bin/bash
#
#
#       Copyright 2022 Alejandro Gomez
#
#       This program is free software: you can redistribute it and/or modify
#       it under the terms of the GNU General Public License as published by
#       the Free Software Foundation, either version 3 of the License, or
#       (at your option) any later version.
#
#       This program is distributed in the hope that it will be useful,
#       but WITHOUT ANY WARRANTY; without even the implied warranty of
#       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#       GNU General Public License for more details.
#
#       You should have received a copy of the GNU General Public License
#       along with this program.  If not, see <http://www.gnu.org/licenses/>.

# VARIABLES Y FUNCONES
DIR_HOME=$(cd $(dirname $0) && pwd)
source "${DIR_HOME}/commonFunctions.sh"
SCRIPT_NAME=$(getJustStriptName $0)

declare -A script_info
export script_info=(
    [name]="${SCRIPT_NAME}"
    [location]="${DIR_HOME}"
    [description]="My large description"
    [calling]="./$(getStriptName $0) DIR FILE"
)

showScriptInfo

function numCoincidencias() {
    fileName=$1
    shift 1
    numTotal=0
    for elemento in $*; do
        if [ "$(cat $fileName | grep $elemento)" != "" ]; then
            numTotal=$(($numTotal + 1))
        fi
    done
    echo $numTotal
}

if [ $# -eq 2 ]; then
    if [ -d "$1" ]; then
        START_DIR="$1"
        ELEMENTOS=$(cat $2)
        showInfo "ELEMENTOS: "$ELEMENTOS
        showInfo "TOTAL DE ELEMENTOS: "$(echo $ELEMENTOS | wc -w)
        for csvFile in $(ls $START_DIR/*.csv); do
            showInfo "$csvFile "$(numCoincidencias $csvFile $ELEMENTOS)
        done
    else
        showInfo "$1 no es un directorio o no existe."
    fi
else
    showError 1 "$(date -u) [ERROR]: Number of incorrect parameters.Must be 1 date"
fi
