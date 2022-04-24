#! /bin/bash

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

# mostramos los indices y sus valores
printf "\nMostramos todos los indices con sus valores \n"
for indice in ${!valores[*]} ; do
    printf "%4d: %s\n" $indice ${valores[$indice]}
done
