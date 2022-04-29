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

# VARIABLES GLOBALES
fichLista="$HOME/bin/datos/lista-backup.txt"
fichLOG="$HOME/bin/log/BACKUP_log.txt"
fichErrorLOG="$HOME/bin/log/BACKUP_error_log.txt"
dirBackup="$HOME/backups"
nomFichGenerado="$dirBackup"'/copia-'`date +%F`'.tar'

# ANTES DE EMPEZAR
if [ ! -f "$fichLista" ] ; then echo "" >> "$fichLista" ; fi
if [ ! -f "$fichLOG" ] ; then echo "" >> "$fichLOG" ; fi
if [ ! -f "$fichErrorLOG" ] ; then echo "" >> "$fichErrorLOG" ; fi
if [ ! -d "$dirBackup" ] ; then mkdir "$dirBackup" ; fi

# Creo los BackUps
lineasficheroLista=`wc -l "$fichLista" | cut -d' ' -f1`
if [ $lineasficheroLista -gt 0 ] && [ "`awk 'NR=='1 $fichLista`" != '' ] ; then
	echo 'Se ha hecho una copia el "'`date +%F` `date +%T`'".' >> $fichLOG
	echo 'Empaquetando....'"$lineasficheroLista"' elementos'
	for linea in `seq 1 $lineasficheroLista` ; do
	    cadena1="`awk 'NR=='$linea $fichLista`"
	    if [ "$cadena1" != '' ] && [ `echo "$cadena1" | cut -d':' -f1` != 2 ] ; then
            directorio="`echo "$cadena1" | cut -d':' -f2`"
            tar -rvf "$nomFichGenerado" "$directorio" 2>> $fichErrorLOG
	    fi
	done
	echo 'Comprimientdo...'
	gzip -v9 "$nomFichGenerado" 2>> $fichErrorLOG
	echo 'La copia ya ha sido realizada.'
fi

