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
    [calling]="./$(getScriptName $0) data data data data"
)

showScriptInfo

if [ $# -lt 2 ] || [ $# -gt 4 ]; then
    showInfo 'Faltan parametros'
    exit 1
else
    if [ -f "$2" ]; then
        case "$1" in
            "-enc-sha")
                showInfo "Codificando..."
                openssl dgst -sha -out "$2".hash "$2"
                ;;
            "-enc-aes")
                showInfo "Codificando..."
                openssl enc -aes-128-cbc -in "$2" "$2".enc
                ;;
            "-dec-aes")
                showInfo "Descodificando..."
                openssl -d -aes-128-cbc -in "$2" "$2".dec
                ;;
            "-dec")
                showInfo "Descodificando..."
                openssl enc -d -in "$2" "$2".dec
                ;;
            "-enc-pri")
                # Para cifrar con privada
                showInfo "Codificando..."
                openssl genpkey -algorithmRSA -out "$2".txt
                ;;
            "-enc-pub")
                # Para cifrar con pública
                showInfo "Codificando..."
                openssl -pkey -in "$2" -pubout -out "$2".salida
                ;;
            "-enc-pub2")
                # Para cifrar con pública 2
                showInfo "Codificando..."
                openssl pkeyutl -pubin -encrypt -in "$2" -out "$2".enc -inkey "$3"
                ;;
            "-dec-pub2")
                # Para cifrar con pública 2
                showInfo "Descodificando..."
                openssl pkeyutl -decrypt -in "$2" -mkey "$3" -out "$2".enc
                ;;
            "-firma")
                # Para hacer una firma
                showInfo "Frimando..."
                openssl pkeyutl -sign -in "$2" -out "$2".sig -inkey "$3"
                ;;
            "-verificar")
                # Para hacer una firma
                showInfo "Verificando..."
                openssl pkeyutl -pubin -verify -sigfile "$4" -in "$2" -inkey "$3"
                ;;
            *)
                showInfo 'Parametro erroneo.'
                ;;
        esac
    else
        showInfo "$2 no es un fichero."
    fi
fi
