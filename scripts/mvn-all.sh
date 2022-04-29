#!/bin/bash

# VARIABLES Y FUNCONES
DIR_HOME=$(cd `dirname $0` && pwd)
source "${DIR_HOME}/commonFunctions.sh"
SCRIPT_NAME=`getStriptNameWithoutExtension $0`

declare -A script_info
export script_info=(
	[name]="${SCRIPT_NAME}" 
	[location]="${DIR_HOME}" 
	[description]="My large description" 
	[calling]="./`getStriptName $0` "
)

showScriptInfo

if [ -f "pom.xml" ] ; then 
	mvn clean
	wait $!
	[ $? -ne 0 ] && { echo "No ha limpiado bien." ; exit 1 }
	# En windows -DskipTests=false
	mvn package -Dmaven.test.skip=true  
else
	echo 'El fichero pom.xml no existe.'
fi
