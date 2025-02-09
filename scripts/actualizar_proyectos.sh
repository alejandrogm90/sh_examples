#!/bin/bash

# VARIABLES
DIR_HOME=$(cd $(dirname $0) && pwd)
source "${DIR_HOME}/commonFunctions.sh"
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

# FUNCIONES
function my_space {
    echo ""
    echo ""
    echo "Actualizando $1"
}

lista_proyectos=($(ls "$HOME/Proyectos"))
for indice in ${!lista_proyectos[*]} ; do
    project="$HOME/Proyectos/${lista_proyectos[$indice]}/"
    echo "$project"
    if [ -d "$project" ] ; then
        my_space "$project"
        cd "$project"
        git pull 2>> /dev/null
        if [ -f "update_modules.sh" ] ; then
            ./update_modules.sh
        fi
    fi
done
