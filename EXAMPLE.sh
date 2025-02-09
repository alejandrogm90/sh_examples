#!/bin/bash

# FUNCIONES
function my_space {
    echo ""
    echo ""
}

# VARIABLES
DIR_HOME=$(cd $(dirname $0) && pwd)
source "${DIR_HOME}/scripts/commonFunctions.sh"
SCRIPT_NAME=$(getJustStriptName $0)
export LOG_FILE="current_log"

declare -A script_info
export script_info=(
    [name]="${SCRIPT_NAME}"
    [location]="${DIR_HOME}"
    [description]="Example of use"
    [calling]="./$(getScriptName $0) yyyymmdd"
)

showScriptInfo

month=$(($(date +%m)))
year=$(($(date +%Y)))

if isValidDate $year $montn; then
    getAllDatesOfOneMonth $year $month
else
    # Write an error in a LOG_FILE
    showError 1 "My error test check"
fi

my_space

reverseList $(getAllDatesWorkables $year $month)

my_space

./scripts/tiposDeDatos.sh a b c d e f g h i j k l

my_space

./scripts/tree2.sh /dev
