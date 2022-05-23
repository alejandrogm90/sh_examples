#!/bin/bash

# sudo apt install figlet cowsay fortune fortunes-es fortunes-es-off

vacas=(`ls /usr/share/cowsay/cows`)
TVACAS=${#vacas[*]}
NVACA=$((RANDOM%$TVACAS))
vaca=${vacas[$NVACA]}
figlet "Hola mundo"
fortune | cowsay -f $vaca
