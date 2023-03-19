#! /bin/bash

# VARIABLES Y FUNCONES
DIR_HOME=$(cd `dirname $0` && pwd)
source "${DIR_HOME}/commonFunctions.sh"
SCRIPT_NAME=`getJustStriptName $0`

declare -A script_info
export script_info=(
	[name]="${SCRIPT_NAME}"
	[location]="${DIR_HOME}"
	[description]="Example of some tipes of data"
	[calling]="./`getStriptName $0` "
)

showScriptInfo

# a b c d e f g h i j k l
echo '$# ' $#
echo '$@ ' $@
echo '$* ' $*
echo '$1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} ' "$1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11}"
shift 1
echo 'shift 1'
echo '$1 $2 $3' $1 $2 $3
echo '$#' $#
echo '$*' $*


printf '\nvalores=(rojo azul verde) \n'
valores=("rojo" "azul" "verde")

# agregamos un dato
valores[3]="amarillo" 

# mostramos el indice 0
printf "\nMostramos el indice 0: %s \n" ${valores[0]}

# tamaño del array
printf "\nMostramos el tamaño del array: %s \n" ${#valores[*]}     

# mostramos los indices y sus valores
printf "\nMostramos todos los indices con sus valores \n"
for indice in ${!valores[*]} ; do
    printf "%4d: %s\n" $indice ${valores[$indice]}
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
