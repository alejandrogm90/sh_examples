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

# sudo apt install figlet cowsay fortune fortunes-es fortunes-es-off

vacas=($(ls /usr/share/cowsay/cows))
TVACAS=${#vacas[*]}
NVACA=$((RANDOM % $TVACAS))
vaca=${vacas[$NVACA]}
figlet "Hi $(whoami)"
fortune | cowsay -f $vaca
