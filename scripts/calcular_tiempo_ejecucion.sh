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

if [ $# -lt 2 ] ; then
    # EXAMPLE ./scripts/calcular_tiempo_ejecucion.sh output.txt scripts/tree2.sh $HOME
    echo "Uso: $0 [path_salida] <path_script>"
    exit 1
fi

path_salida="$1"
shift 1

#/usr/bin/time -f "\t%E real,\t%U user,\t%S sys" "$@" > /dev/null
#/usr/bin/time -f "real\t\t%E\nuser\t\t%U\nsys\t\t\t%S" -o "$path_salida" "$@" > /dev/null
echo "real,user,sys" > "$path_salida"
/usr/bin/time -f "%E,%U,%S" "$@" > /dev/null 2>> "$path_salida"

