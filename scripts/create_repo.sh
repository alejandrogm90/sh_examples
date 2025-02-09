#!/bin/bash

# To add your local repository
# git remote add origin git@"$192.168.1.200":pi_test_project.git

# VARIABLES
DIR_HOME=$(cd $(dirname $0) && pwd)
source "${DIR_HOME}/commonFunctions.sh"

IP_LOCAL=$(getLocalIp)
showMsg "Tu IP local es: $IP_LOCAL"

# USER es git "/home/git/"
USER_HOME=~
if [ "$USER_HOME" != "/home/git" ]; then
  showError 1 "tu home debe ser \"/home/git\", pero es \"$USER_HOME\""
fi

if [ $# -eq 1 ] ; then
    REPO_NAME="$1.git"
    if [ ! -d "$REPO_NAME" ] ; then
        git init --bare "$USER_HOME/$REPO_NAME"
        if [ $? -eq 0 ] ; then
            showMsg "Repository $REPO_NAME has been created. Use that command:"
            showMsg "git remote add origin git@$IP_LOCAL:$REPO_NAME"
        else
            showError 4 "Creating repository directory"
        fi
    else
        showError 3 "Directory $REPO_NAME already exist."
    fi
else
    showError 2 "$0 [Repository_name]"
fi
