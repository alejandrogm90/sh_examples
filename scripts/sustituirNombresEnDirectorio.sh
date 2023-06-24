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
DIR_HOME=$(cd `dirname $0` && pwd)
source "${DIR_HOME}/commonFunctions.sh"
SCRIPT_NAME=`getJustStriptName $0`
ficheroTemporal="/tmp/`echo "$0" | cut -d'/' -f5`.tmp"
lineasFicheroTemporal=0

declare -A script_info
export script_info=(
	[name]="${SCRIPT_NAME}" 
	[location]="${DIR_HOME}" 
	[description]="Raplaces all file names in a directory for a string"
	[calling]="./`getStriptName $0` [DIRECTORIO] [CADENA-ORIGINAL] [CADENA-SUSTITUTA]"
)

showScriptInfo

if [ $1 == '-h' ] || [ $1 == '--help' ] ; then
  showError 1 '\n [DIRECTORIO] [CADENA-ORIGINAL] [CADENA-SUSTITUTA]'
fi
if [ $# -ne 3 ] ; then
  showInfo 'El número de parámetros introducidos es erroneo.' ;
  showError 2 '\n [DIRECTORIO] [CADENA-ORIGINAL] [CADENA-SUSTITUTA]'
fi
if [ ! -d $1 ] ; then
  showInfo 'El directorio "'$1'" no existe.'
  showError 3 '\n [DIRECTORIO] [CADENA-ORIGINAL] [CADENA-SUSTITUTA]'
fi

ls $1 >> $ficheroTemporal
lineasFicheroTemporal=`wc -l $ficheroTemporal | cut -d' ' -f1`

for linea in `seq 1 $lineasFicheroTemporal` ; do
	cadena1="`awk 'NR=='$linea $ficheroTemporal`"
	cadena2="`echo "$cadena1" | sed -e "s/$2/$3/g" `"
	mv "$1/$cadena1" "$1/$cadena2" &> /dev/null
	showInfo "$cadena1"' -> '`echo "$cadena1" | sed -e "s/$2/$3/g" `
done

# Elimino los ficheros temporales
if [ -f $ficheroTemporal ] ; then
  rm $ficheroTemporal
fi
