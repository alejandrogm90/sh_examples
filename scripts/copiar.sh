#!/bin/bash
#
#
#       Copyright 2024 Alejandro Gomez
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

if [ $# -ne 2 ]; then
  echo "Uso: $0 <directorio_fuente> <directorio_destino>"
  exit 1
fi

SOURCE="$1"
DEST="$2"

if [ ! -d "$SOURCE" ]; then
  echo "Error: El directorio fuente '$SOURCE' no existe"
  exit 1
fi

if [ ! -d "$DEST" ]; then
  echo "Advertencia: El directorio destino '$DEST' no existe. Creándolo..."
  mkdir -p "$DEST"
fi

if [ "$SOURCE" = "$DEST" ]; then
  echo "Error: Los directorios fuente y destino son los mismos"
  exit 1
fi

TOTAL_FILES=$(find "$SOURCE" -type f | wc -l)
TOTAL_DIRS=$(find "$SOURCE" -type d | wc -l)
TOTAL_ITEMS=$((TOTAL_FILES + TOTAL_DIRS))
COPIED_ITEMS=0

find "$SOURCE" -print0 |
while IFS= read -r -d '' item; do
  if [ -d "$item" ]; then
    mkdir -p "${item/$SOURCE/$DEST}"
  else
    cp "$item" "${item/$SOURCE/$DEST}"
  fi
  ((COPIED_ITEMS++))
  PERCENTAGE=$(( (COPIED_ITEMS * 100) / TOTAL_ITEMS ))
  echo -ne "\r$PERCENTAGE%"
done
echo "Todos los datos han sido copiados ..."
