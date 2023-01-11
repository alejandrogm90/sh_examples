#!/bin/bash

# VARIABLES Y FUNCONES
DIR_HOME=$(cd `dirname $0` && pwd)
source "${DIR_HOME}/commonFunctions.sh"
SCRIPT_NAME=`getJustStriptName $0`
DIR_COMUN="$HOME"
HOY=$(date +%F)' '$(date +%T)
LOCAL_IP="`~/bin/miIP.py -l`"

declare -A script_info
export script_info=(
	[name]="${SCRIPT_NAME}" 
	[location]="${DIR_HOME}" 
	[description]="My large description" 
	[calling]="./`getStriptName $0` DIR FILE"
)

showScriptInfo

# Correction of possible errors
#========================================================
FILE_IP=$DIR_COMUN'/.CURRENT_IP.tmp'
if [ ! -f $FILE_IP ] || [ ! -s $FILE_IP ] ; then 
    echo $LOCAL_IP > $FILE_IP
fi
FILE_OUTPUT=$DIR_COMUN'/.INFORM.tmp'
if [ ! -f $FILE_OUTPUT ] ; then 
	echo '' > "$FILE_OUTPUT" 
fi


# Creating the data file
#========================================================
echo 'Host: '$HOSTNAME > $FILE_OUTPUT
echo 'Fecha: '$HOY >> $FILE_OUTPUT
echo 'My global IP is: '$LOCAL_IP >> $FILE_OUTPUT
if [ "$LOCAL_IP" != "`head -1 $FILE_IP`" ] ; then
	echo 'My last local IP was: '"`head -1 $FILE_IP`" >> $FILE_OUTPUT
	echo $LOCAL_IP > $FILE_IP
fi
echo 'My local IP is: '$LOCAL_IP >> $FILE_OUTPUT
mpstat -P ALL >> $FILE_OUTPUT
echo ' ' >> $FILE_OUTPUT
free -h >> $FILE_OUTPUT


# Send by mail or show on screen
#========================================================
if [ $# -eq 1 ] && [ $1 == "enviar" ] ; then
	if [ "$LOCAL_IP" != "`head -1 $FILE_IP`" ] ; then
		~/bin/enviarCorreo.py $FILE_OUTPUT
	fi
else
	cat $FILE_OUTPUT
fi

# Delete temporal files
rm $FILE_OUTPUT

