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
	[calling]="./`getStriptName $0` DIR FILE"
)

showScriptInfo

LOCAL_IP="`miIP.py -l`"
GLOBAL_IP="`miIP.py -g`"
FILE_OUTPUT=~/.INFORM.tmp
FILE_IP=~/.CURRENT_IP.tmp

# Correction of possible errors
#========================================================
if [ ! -f "$FILE_IP" ] || [ ! -s "$FILE_IP" ] ; then
    echo "$LOCAL_IP" > "$FILE_IP"
fi
if [ ! -f "$FILE_OUTPUT" ] || [ ! -s "$FILE_OUTPUT" ] ; then
    echo "" > "$FILE_OUTPUT"
fi

# Creating the data file
#========================================================
echo 'Host: '$HOSTNAME > "$FILE_OUTPUT"
echo 'Date: '$(date +%F)' '$(date +%T) >> "$FILE_OUTPUT"
echo ' ' >> "$FILE_OUTPUT"
echo 'LOCAL IP: '$LOCAL_IP >> "$FILE_OUTPUT"
echo 'GLOBAL IP: '$GLOBAL_IP >> "$FILE_OUTPUT"
echo ' ' >> "$FILE_OUTPUT"
temDatos="/tmp/miCPU-tem"
lscpu > "$temDatos"
for linea in 1 2 3 4 10 13 ; do
	echo "`awk NR==$linea $temDatos`" >> "$FILE_OUTPUT"
done
echo ' ' >> "$FILE_OUTPUT"
free -m | awk 'NR==2{printf "Memory Usage: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }' >> "$FILE_OUTPUT"
df -h | awk '$NF=="/"{printf "Disk Usage: %d/%dGB (%s)\n", $3,$2,$5}' >> "$FILE_OUTPUT"
top -bn1 | grep load | awk '{printf "CPU Load: %.2f\n", $(NF-2)}' >> "$FILE_OUTPUT"
echo ' ' >> "$FILE_OUTPUT"
ps -eocomm,pcpu | egrep -v '(0.0)|(%CPU)'  >> "$FILE_OUTPUT"

# Send by mail or show on screen
#========================================================
if [ $# -eq 1 ] && [ $1 == "enviar" ] ; then
	if [ "$LOCAL_IP" != "`head -1 $FILE_IP`" ] ; then
		enviarCorreo.py "$FILE_OUTPUT"
	fi
else
	cat "$FILE_OUTPUT"
fi

# Delete temporal files
#========================================================
rm "$FILE_OUTPUT"
