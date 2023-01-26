#!/bin/bash

# VARIABLES Y FUNCONES
DIR_HOME=$(cd $(dirname $0) && pwd)
source "${DIR_HOME}/commonFunctions.sh"
SCRIPT_NAME=$(getJustStriptName $0)

declare -A script_info
export script_info=(
  [name]="${SCRIPT_NAME}"
  [location]="${DIR_HOME}"
  [description]="Create a backup"
  [calling]="./$(getStriptName $0) "
)

showScriptInfo

# VARIABLES GLOBALES
fichLista="$HOME/bin/datos/lista-backup.txt"
dirBackup="$HOME/backups"
nomFichGenerado="$dirBackup"'/copia-'$(date +%F)'.tar'

# ANTES DE EMPEZAR
if [ ! -f "$fichLista" ]; then
  showError 1 "El fichero $fichLista no existe."
fi
if [ ! -d "$dirBackup" ]; then
  showError 2 "El directorio $dirBackup no existe."
fi

# Creo los BackUps
lineasficheroLista=$(wc -l "$fichLista" | cut -d' ' -f1)
if [ $lineasficheroLista -gt 0 ] && [ "$(awk 'NR=='1 $fichLista)" != '' ]; then
  showInfo 'Se ha hecho una copia el "'$(date +%F) $(date +%T)'".'
  showInfo 'Empaquetando....'"$lineasficheroLista"' elementos'
  numElementos=0
  for linea in $(seq 1 $lineasficheroLista); do
    cadena1="$(awk 'NR=='$linea $fichLista)"
    if [ "$cadena1" != '' ] && [ $(echo "$cadena1" | cut -d':' -f1) != 2 ]; then
      elemento="$(echo "$cadena1" | cut -d':' -f2)"
      if [ -d "$elemento" ] || [ -f "$elemento" ] ; then
        tar -rvf "$nomFichGenerado" "$elemento"
        numElementos=$(( $numElementos + 1 ))
      fi
    fi
  done
  if [ $numElementos -gt 0 ] ; then
    showInfo 'Comprimiendo...'
    gzip -v9 "$nomFichGenerado"
    showInfo 'La copia ya ha sido realizada.'
  else
    showError 'No hay elementos que copiar.'
  fi
fi
