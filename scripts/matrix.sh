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

# VARIABLES
DIR_HOME=$(cd $(dirname $0) && pwd)
source "${DIR_HOME}/commonFunctions.sh"
SCRIPT_NAME=$(getJustStriptName $0)

declare -A script_info
export script_info=(
    [name]="${SCRIPT_NAME}"
    [location]="${DIR_HOME}"
    [description]="My large description"
    [calling]="./$(getScriptName $0) DIR FILE"
)

showScriptInfo

dir1=~/bin

if [ -d "$dir1" ]; then
    texto=""
    lista_ficheros=($(ls "$dir1"))
    numero_ficeros=${#lista_ficheros[*]}
    numero_actual=$numero_ficeros
    for indice in ${!lista_ficheros[*]}; do
        cat "$dir1/${lista_ficheros[$indice]}"
        numero_actual=$(($numero_actual - 1))
        texto="$texto#"
        echo "Progress $texto [ %"$((100 - (($numero_actual * 100) / $numero_ficeros)))' ]'
        sleep 1
    done
else
    echo "No existe $dir1"
fi
