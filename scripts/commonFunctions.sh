#!/bin/bash

# GLOBAL VARIABLES
export SEPARATOR_1="###############################################################################################"

# SHOW THE ERROR AND END THE SCRIPT
function showError
{
    numError=${1}
    shift 1
    echo $*
    echo "LOG_FILE: ${LOG_FILE}"
    if [ "${LOG_FILE}" != "" ] ; then echo " $(date -u) [ ERROR ] ( ${numError} ): $*" >> "${LOG_FILE}" ; fi
    exit $numError
} 

# TEXT WITH FORMAT ACCORDING TO THE FIRST PARAMETER 
function textWithFormat
{
    if [ ${1} -eq 1 ] ; then
        shift 1
        echo "$*"
    else
        shift 1
        echo "" 
        echo ""
        echo "$*"
        echo ""
        echo ""
    fi
} 

# RETURN THE NAME OF THE SCRIPT 
function getStriptName {
    echo "${*##*/}"
}

# RETURN THE NAME OF THE SCRIPT WITHOUT EXTENSION 
function getJustStriptName {
    name=`getStriptName $*`
    echo "${name%.*}"
}

# RETURN THE SCRIPT LOCATION
function getStriptLocation {
    echo $(cd `dirname $*` && pwd)
}

# SHOW SCRIPT INFORMATION 
function showScriptInfo {
    echo "$SEPARATOR_1"
    echo "# Name            : ${script_info[name]}"
    echo "# Location        : ${script_info[location]}"
    echo "# Description     : ${script_info[description]}"
    echo "# Autor           : ${script_info[Autor]}"
    echo "# Execution_Date  : `date +%Y%m%d%H%M%S`"
    echo "# Calling         : ${script_info[calling]}"
    echo "$SEPARATOR_1"
}

# RETURN STRING FORMAT 
function minor10 {
    if [ $1 -lt 10 ] ; then 
        echo "0"$1
    else
        echo $1
    fi
}
