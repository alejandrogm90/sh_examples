#!/bin/bash

#
#
#       Copyright 2017 Alejandro Gomez
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

# VARIABLES GLOBALES
COMPARTIDA="/opt/COMPARTIDA"
dirBIN=$COMPARTIDA"/PROYECTOS/myBIN/bin"

#Muestra versión de linux
lsb_release -a

# POR MI PARTE ....
#if [ -f "$dirBIN/archey.py" ] ; then $dirBIN/archey.py ; fi
if [ -f "$dirBIN/miCPU.sh" ] ; then $dirBIN/miCPU.sh ; fi
if [ -f "$dirBIN/modificaciones.sh" ] ; then $dirBIN/modificaciones.sh ; fi
if [ -f "$COMPARTIDA/datos/frases" ] ; then cat $COMPARTIDA/datos/frases ; fi

