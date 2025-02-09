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

# VARIABLES Y FUNCONES
DIR_HOME=$(cd $(dirname $0) && pwd)
source "${DIR_HOME}/commonFunctions.sh"
SCRIPT_NAME=$(getJustStriptName $0)

declare -A script_info
export script_info=(
    [name]="${SCRIPT_NAME}"
    [location]="${DIR_HOME}"
    [description]="My large description"
    [calling]="./$(getScriptName $0) DIR FILE"
)

showScriptInfo

### 1. get total average CPU usage for the past minute
avg_cpu_use=$(uptime)
# a. split response
IFS=',' read -ra avg_cpu_use_arr <<<"$avg_cpu_use"
# b. find cpu usage
avg_cpu_use=""
for i in "${avg_cpu_use_arr[@]}"; do
    :
    if [[ $i == *"load average"* ]]; then
        avg_cpu_use=$i
        break
    fi
done
# c. create response
avg_cpu_use=$(echo ${avg_cpu_use:16}) # Remove "  load average: "
if [[ -z "${avg_cpu_use// /}" ]]; then
    avg_cpu_use="CPU: N/A%%"
    exit -1
else
    avg_cpu_use="CPU: ${avg_cpu_use}%%"
fi

### 2. get RAM usage
ram_use=$(free -m)
# a. split response by new lines
IFS=$'\n' read -rd '' -a ram_use_arr <<<"$ram_use"
# b. remove extra spaces
ram_use="${ram_use_arr[1]}"
ram_use=$(echo "$ram_use" | tr -s " ")
# c. split response by spaces
IFS=' ' read -ra ram_use_arr <<<"$ram_use"
# d. get variables
total_ram="${ram_use_arr[1]}"
ram_use="${ram_use_arr[2]}"
# e. create response
ram_use="RAM: ${ram_use}/${total_ram} MB"

echo $avg_cpu_use
echo $ram_use
