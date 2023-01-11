#!/bin/bash

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

# Funciones
function error1 () { echo '\n [DIRECTORIO] [CADENA-ORIGINAL] [CADENA-SUSTITUTA]' ; exit $1 }		# Fución de salida de error

if [ $1 == '-h' ] || [ $1 == '--help' ] ; then error1 1 ; fi						# Para la ayuda
if [ $# -ne 3 ] ; then echo 'El número de parámetros introducidos es erroneo.' ; error1 2 ; fi		# Posible error en el número de parámetros introducidos
if [ ! -d $1 ] ; then echo 'El directorio "'$1'" no existe.' ; error1 3 ; fi				# Por si el directorio no existe

ls $1 >> $ficheroTemporal
lineasFicheroTemporal=`wc -l $ficheroTemporal | cut -d' ' -f1`

for linea in `seq 1 $lineasFicheroTemporal` ; do
	cadena1="`awk 'NR=='$linea $ficheroTemporal`"
	cadena2="`echo "$cadena1" | sed -e "s/$2/$3/g" `"
	mv "$1/$cadena1" "$1/$cadena2" &> /dev/null
	echo "$cadena1"' -> '`echo "$cadena1" | sed -e "s/$2/$3/g" `
done

if [ -f $ficheroTemporal ] ; then rm $ficheroTemporal ; fi						# Elimino los ficheros temporales



