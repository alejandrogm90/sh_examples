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
	[calling]="./`getStriptName $0` "
)

showScriptInfo

if [ -f "pom.xml" ] ; then 
	mvn clean
	wait $!
	if [ $? -ne 0 ] ; then 
		showError 1 "No ha limpiado bien."
	fi
	# En windows -DskipTests=false
	mvn -Dmaven.test.skip=true \
	-Dmaven.wagon.http.ssl.insecure=true \
	-Dmaven.wagon.http.ssl.allowall=true \
	-Dmaven.wagon.http.ssl.ignore.validity.dates=true \
	install
else
	echo 'El fichero pom.xml no existe.'
fi
