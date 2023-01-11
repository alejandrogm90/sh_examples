#!/bin/bash

# VARIABLES Y FUNCONES
DIR_HOME=$(cd `dirname $0` && pwd)
source "${DIR_HOME}/commonFunctions.sh"
SCRIPT_NAME=`getJustStriptName $0`

declare -A script_info
export script_info=(
	[name]="${SCRIPT_NAME}" 
	[location]="${DIR_HOME}" 
	[description]="My large description" 
	[calling]="./`getStriptName $0` data data data data"
)

showScriptInfo

if [ $# -lt 2 ] || [ $# -gt 4 ] ; then 
	echo 'Faltan parametros'
	exit 1 
else
	if [ -f "$2" ] ; then
		case "$1" in
			"-enc-sha")
				echo "Codificando..."
				openssl dgst -sha -out "$2".hash "$2" ;;
			"-enc-aes")
				echo "Codificando..."
				openssl enc -aes-128-cbc -in "$2" "$2".enc ;;
			"-dec-aes")
				echo "Descodificando..."
				openssl -d -aes-128-cbc -in "$2" "$2".dec ;;
			"-dec")
				echo "Descodificando..."
				openssl enc -d -in "$2" "$2".dec ;;
			"-enc-pri")
				# Para cifrar con privada
				echo "Codificando..."
				openssl genpkey -algorithmRSA -out "$2".txt ;;
			"-enc-pub")
				# Para cifrar con pública
				echo "Codificando..."
				openssl -pkey -in "$2" -pubout -out "$2".salida ;;
			"-enc-pub2")
				# Para cifrar con pública 2
				echo "Codificando..."
				openssl pkeyutl -pubin -encrypt -in "$2" -out "$2".enc -inkey "$3" ;;
			"-dec-pub2")
				# Para cifrar con pública 2
				echo "Descodificando..."
				openssl pkeyutl -decrypt -in "$2" -mkey "$3" -out "$2".enc ;;
			"-firma")
				# Para hacer una firma
				echo "Frimando..."
				openssl pkeyutl -sign -in "$2" -out "$2".sig -inkey "$3" ;;
			"-verificar")
				# Para hacer una firma
				echo "Verificando..."
				openssl pkeyutl -pubin -verify -sigfile "$4" -in "$2" -inkey "$3" ;;
			*)
				echo 'Parametro erroneo.' ;;
		esac
	else
		echo $2' no es un fichero.'
	fi
fi


