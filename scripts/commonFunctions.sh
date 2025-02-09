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

# GLOBAL VARIABLES
export SEPARATOR_1="###############################################################################################"

function showMsg {
    # SHOW INFO
    tipeLine=$1
    shift 1
    headLine="[$(date +%F'_'%T)][$tipeLine]:"
    echo "$headLine $*"
    if [ "${LOG_FILE}" != "" ]; then
        echo "$headLine $*" >>"${LOG_FILE}"
    fi
}

function showInfo {
    # SHOW INFO
    showMsg INFO $*
}

function showWarn {
    # SHOW WARN
    showMsg WARN $*
}

function showError {
    # SHOW THE ERROR AND END THE SCRIPT
    numError=${1}
    shift 1
    echo "[$(date +%F'_'%T)][ERROR][${numError}]: $*"
    if [ "${LOG_FILE}" != "" ]; then
        echo "[$(date +%F'_'%T)][ERROR][${numError}]: $*" >>"${LOG_FILE}"
    fi
    exit $numError
}

function showScriptInfo {
    # SHOW SCRIPT INFORMATION
    echo "$SEPARATOR_1"
    echo "# Name            : ${script_info[name]}"
    echo "# Location        : ${script_info[location]}"
    echo "# Description     : ${script_info[description]}"
    echo "# Autor           : ${script_info[Autor]}"
    echo "# Execution_Date  : $(date +"%Y-%m-%d %H:%M:%S")"
    echo "# Calling         : ${script_info[calling]}"
    echo "$SEPARATOR_1"
}

function textWithFormat {
    # TEXT WITH FORMAT ACCORDING TO THE FIRST PARAMETER
    if [ ${1} -eq 1 ]; then
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

function getScriptName {
    # RETURN THE NAME OF THE SCRIPT
    echo "${*##*/}"
}

function getJustStriptName {
    # RETURN THE NAME OF THE SCRIPT WITHOUT EXTENSION
    name=$(getScriptName $*)
    echo "${name%.*}"
}

function getScriptLocation {
    # RETURN THE SCRIPT LOCATION
    echo $(cd $(dirname $*) && pwd)
}

function minor10 {
    # RETURN STRING FORMAT
    if [ ! $# -ne 1 ]; then
        if [ $1 -lt 10 ]; then
            echo "0"$1
        else
            echo $1
        fi
    fi
}

function isValidDate {
    # RETURN 1 IF ALL IS RIGHT ABOUT DATE SEND
    if [ ! $# -ne 2 ] && [ ! $1 -lt 1 ] && [ ! $2 -lt 1 ] && [ ! $2 -gt 12 ]; then
        return 1
    fi
    return 0
}

function getAllDatesOfOneMonth {
    # RETURN STRING FORMAT YYYY-MM-DD ( USES YEAR AND MONTH AS PARAMETERS )
    currentDate=$1"-"$(minor10 $2)"-01"
    currentMonth=$(date +%m --date $currentDate)
    while [ $currentMonth -eq $(date +%m --date $currentDate) ]; do
        echo $currentDate
        currentDate=$(date +%F --date $currentDate' +1 days')
    done
}

function getAllDatesWorkables {
    # RETURN STRING FORMAT YYYY-MM-DD WORKABLE DAYS ( USES YEAR AND MONTH AS PARAMETERS )
    for currentDay in $(getAllDatesOfOneMonth $1 $2); do
        currentDayText=$(date +%a --date $currentDay)
        if [ "$currentDayText" != "Sun" ] && [ "$currentDayText" != "Sat" ]; then
            echo $currentDay
        fi
    done
}

function lastDateWorkableOfMonth {
    # RETURN STRING FORMAT YYYY-MM-DD LAST WORKABLE DATE ( USES YEAR AND MONTH AS PARAMETERS )
    allDays=($(getAllDatesWorkables $1 $2))
    lastPosition=$((${#allDays[*]} - 1))
    echo ${allDays[$lastPosition]}
}

function lastDateOfMonth {
    # RETURN STRING FORMAT YYYY-MM-DD LAST DATE ( USES YEAR AND MONTH AS PARAMETERS )
    allDays=$(getAllDatesOfOneMonth $1 $2)
    lastPosition=$((${#allDays[*]} - 1))
    echo ${allDays[$lastPosition]}
}

function reverseList {
    # RETURN REVERSE LIST
    valores=($*)
    for indice in $(seq $# -1 0); do
        echo ${valores[$indice]}
    done
}

function getValueFromJsonFileStructured() {
    # RETURN THE VALUE FROM A JSON FILE
    CADENA=$(cat $1 | grep $2 | cut -d'"' -f2)
    echo "$CADENA"
}

function getLocalIp() {
    # Get local IP
    CADENA=$(ip addr show | grep "inet " | grep -v "127.0.0.1" | head -1 | awk '{print $2}' | cut -d/ -f1)
    echo "$CADENA"
}

function getRouterIp() {
    # Get router IP
    CADENA=$(ip route show default | grep "default" | awk '{print $3}')
    echo "$CADENA"
}
