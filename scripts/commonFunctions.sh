#!/bin/bash

# GLOBAL VARIABLES
export SEPARATOR_1="###############################################################################################"

# SHOW INFO
function showMsg {
    tipeLine=$1
    shift 1
    headLine="[`date +%F'_'%T`][$tipeLine]:"
    echo "$headLine $*"
    if [ "${LOG_FILE}" != "" ] ; then 
        echo "$headLine $*" >> "${LOG_FILE}"    
    fi
}

# SHOW INFO
function showInfo {
    showMsg INFO $*
}

# SHOW WARN
function showWarn {
    showMsg WARN $*
}

# SHOW THE ERROR AND END THE SCRIPT
function showError {
    numError=${1}
    shift 1
    echo "[`date +%F'_'%T`][ERROR][${numError}]: $*"
    if [ "${LOG_FILE}" != "" ] ; then 
        echo "[`date +%F'_'%T`][ERROR][${numError}]: $*" >> "${LOG_FILE}"    
    fi
    exit $numError
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

# TEXT WITH FORMAT ACCORDING TO THE FIRST PARAMETER 
function textWithFormat {
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

# RETURN STRING FORMAT 
function minor10 {
    if [ ! $# -ne 1 ] ; then
        if [ $1 -lt 10 ] ; then 
            echo "0"$1
        else
            echo $1
        fi
    fi
}

# RETURN 1 IF ALL IS RIGTH ABOUT DATE SEND
function isValidDate {
    if [ ! $# -ne 2 ] && [ ! $1 -lt 1 ] &&[ ! $2 -lt 1 ] && [ ! $2 -gt 12 ] ; then
        return 1
    fi
    return 0
}

# RETURN STRING FORMAT YYYY-MM-DD ( USES YEAR AND MONTH AS PARAMETERS )
function getAllDatesOfOneMonth {
    currentDate=$1"-"`minor10 $2`"-01"
    currentMonth=$(date +%m --date $currentDate )
    while [ $currentMonth -eq $(date +%m --date $currentDate ) ] ; do
        echo $currentDate
        currentDate=$(date +%F --date $currentDate' +1 days')            
    done
}

# RETURN STRING FORMAT YYYY-MM-DD WORKABLE DAYS ( USES YEAR AND MONTH AS PARAMETERS )
function getAllDatesWorkables {
    for currentDay in `getAllDatesOfOneMonth $1 $2` ; do
        currentDayText=$(date +%a --date $currentDay )
        if [ "$currentDayText" != "Sun" ] && [ "$currentDayText" != "Sat" ] ; then
            echo $currentDay
        fi
    done
}

# RETURN STRING FORMAT YYYY-MM-DD LAST WORKABLE DATE ( USES YEAR AND MONTH AS PARAMETERS )
function lastDateWorkableOfMonth {
    allDays=(`getAllDatesWorkables $1 $2`)
    lastPosition=$(( ${#allDays[*]} - 1 ))
    echo ${allDays[$lastPosition]}
}

# RETURN STRING FORMAT YYYY-MM-DD LAST DATE ( USES YEAR AND MONTH AS PARAMETERS )
function lastDateOfMonth {
    allDays=(`getAllDatesOfOneMonth $1 $2`)
    lastPosition=$(( ${#allDays[*]} - 1 ))
    echo ${allDays[$lastPosition]}
}

# RETURN REVERSE LIST
function reverseList {
    valores=($*)
    for indice in `seq $# -1 1` ; do
        echo ${valores[$indice]}
    done
}

# RETUR THE VALUE FROM A JSON FILE
function getValueFromJsonFileStructured() {
	echo "`cat $1 | grep $2 | cut -d'"' -f2`"
}
