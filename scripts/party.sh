#!/bin/bash

#Launcher path
launcher_path="$HOME/Proyectos/coomer_party"

cd "$launcher_path" || exit 1
if [ -f nohup.out ] ; then
        rm nohup.out
fi

for p1 in "$@" ; do
    # echo "$p1"
    nohup pipenv run python3 main.py -ua "$p1" &
done
