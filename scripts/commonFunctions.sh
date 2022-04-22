#!/bin/bash

#
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
    echo "###############################################################################################"
    echo "#Name            : ${script_info[name]}"
    echo "#Location        : ${script_info[location]}"
    echo "#Description     : ${script_info[description]}"
    echo "#Autor           : ${script_info[Autor]}"
    echo "#Execution_Date  : `date +%Y%m%d%H%M%S`"
    echo "#Calling         : ${script_info[calling]}"
    echo "###############################################################################################"
}

