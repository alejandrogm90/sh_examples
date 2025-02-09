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
    [description]="A example of date types usage"
    [calling]="./$(getScriptName $0) "
)

showScriptInfo

HOY=$(date +%Y/%m/%d)
AYER=$(date --date "yesterday" +%Y/%m/%d)
MANA=$(date --date "tomorrow" +%Y/%m/%d)
showInfo 'TODOS los datos por separado: '$(date +%Y)'-'$(date +%m)'-'$(date +%d)' '$(date +%T)
showInfo 'La fecha en segundos desde 1970-01-01 00:00:00 UTC es: '$(date +%s)
showInfo "Ayer fue : $AYER"
showInfo "Hoy es : $HOY"
showInfo "Mañana será : $MANA"
