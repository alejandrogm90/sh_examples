#! /bin/bash

HOY=$(date +%Y/%m/%d)
AYER=$(date --date "yesterday" +%Y/%m/%d)
MANA=$(date --date "tomorrow" +%Y/%m/%d)
echo 'TODOS los datos por separado: '`date +%Y`'-'`date +%m`'-'`date +%d`' '`date +%T`
echo 'La fecha en segundos desde 1970-01-01 00:00:00 UTC es: '`date +%s`
echo "Ayer fue : $AYER"
echo "Hoy es : $HOY"
echo "Mañana será : $MANA"

