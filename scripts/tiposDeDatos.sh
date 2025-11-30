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

# VARIABLES Y FUNCIONES
DIR_HOME=$(cd "$(dirname "$0")" && pwd)
source "${DIR_HOME}/commonFunctions.sh"
SCRIPT_NAME=$(getJustStriptName "$0")

declare -A script_info
export script_info=(
    [name]="${SCRIPT_NAME}"
    [location]="${DIR_HOME}"
    [description]="Example of some tipes of data"
    [calling]="./$(getScriptName "$0") "
)

showScriptInfo

# a b c d e f g h i j k l
echo '$# '"$#"
echo '$@ '"$@"
echo '$* '"$*"
echo '$1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} '"$1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11}"
shift 1
echo 'shift 1'
echo '$1 $2 $3 '"$1 $2 $3"
echo '$# '"$#"
echo '$* '"$*"

printf '\nvalores=(rojo azul verde) \n'
valores=("rojo" "azul" "verde")

# agregamos un dato
valores[3]="amarillo"

# mostramos el indice 0
printf "\nMostramos el indice 0: %s \n" "${valores[0]}"

# tamaño del array
printf "\nMostramos el tamaño del array: %s \n" "${#valores[*]}"

# mostramos los indices y sus valores
printf "\nMostramos todos los indices con sus valores \n"
for indice in ${!valores[*]}; do
    printf "%4d: %s\n" "$indice" "${valores[$indice]}"
done

case $1 in
    "a")
        echo "A"
        ;;

    "b")
        echo "B"
        ;;
    *)
        echo "Other"
        ;;
esac
