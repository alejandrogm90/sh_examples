#!/bin/bash

#
#
#       Copyright 2017 Alejandro Gómez Martín
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

#VARIABLES
accion=0

function error1 () {
    echo ''
    echo ' [ARGUMENT] [VARIABLE]'
    echo ' ALL ARGUMENTS'
    echo ' -h o --help              Help.'
    echo ' -cr o --create           Create a new project.'
    echo ' -co o --codificate       Codificate a project as ".deb"'
    echo ''
}

if [ $1 == '-h' ] || [ $1 == '--help' ] ; then error1 ; exit 1 ; fi
if [ $# -ne 2 ] ; then echo 'Input error.' ; error1 ; exit 2 ; fi
if [ -f $2 ] ; then echo 'The file "'$2'" already exist.' ; exit 3 ; fi

if [ $1 == "-cr" ] || [ $1 == "--create" ] ; then accion=1 ; fi
if [ $1 == "-co" ] || [ $1 == "--codificate" ] ; then accion=2 ; fi

case $accion in
    1)
        mkdir $2
        # APP
        mkdir -p $2/usr/share/$2
        echo '' >> $2/usr/share/$2/launch.py
        echo '' >> $2/usr/share/$2/icon.png
        # program.desktop file
        mkdir -p $2/usr/share/applications
        cat > $2/usr/share/applications/$2.desktop << __EOF__
[Desktop Entry]
Version=0.1
Name=$2
Comment=Comment
Exec=/usr/share/$2/launch.py
Terminal=false
Type=Application
Categories=Utility;
Icon=icon.png
__EOF__
        # AUTHORS, COPYNG, README
        mkdir -p $2/usr/share/doc/$2
        echo '' >> $2/usr/share/doc/$2/README
        echo '' >> $2/usr/share/doc/$2/AUTHORS
        echo '' >> $2/usr/share/doc/$2/copyright
        # MENU GNOME
        mkdir -p $2/usr/share/menu
        cat > $2/usr/share/menu/$2 << __EOF__
?package($2):needs="X11" section="Applications/optional"
title="$2" command="/usr/share/$2/launch.py"
description="description"
icon="/usr/share/$2/icon.png"
__EOF__
        # El directorio final de configuración de estos ficheros
        # una vez instalados es: /var/lib/dpkg/info/*
        # CONTROL FILE
        mkdir $2/DEBIAN
        cat > $2/DEBIAN/control << __EOF__
Source: $2
Package: $2
Priority: optional
Section: misc
Maintainer: your_name <your_mail@mail.com>
Homepage: http://www.your-webside.com/
Architecture: all
Version: 1.0
Pre-Depends: python3
Origin: your_origin
Description: descripcion
 Long descripcion .

__EOF__
        # BEFORE INSTALLATION - FILE
        cat > $2/DEBIAN/preinst << __EOF__
#! /bin/bash -e

__EOF__
        # AFTER INSTALLATION - FILE
        cat > $2/DEBIAN/postinst << __EOF__
#! /bin/bash -e
update-mime-database /usr/share/mime
__EOF__
        # BEFORE REMOVE - FILE
	cat > $2/DEBIAN/prerm << __EOF__
#! /bin/bash -e
__EOF__
        # AFTER REMOVE - FILE
	cat > $2/DEBIAN/postrm << __EOF__
#! /bin/bash -e

__EOF__
    ;;
    2)
        sudo chmod -R 775 "$2"
        sudo chown -R root:root $2
        if [ -f $2/DEBIAN/preinst ] ; then sudo chmod 555 $2/DEBIAN/preinst ; fi
        if [ -f $2/DEBIAN/postinst ] ; then sudo chmod 555 $2/DEBIAN/postinst ; fi
        if [ -f $2/DEBIAN/prerm ] ; then sudo chmod 555 $2/DEBIAN/prerm ; fi
        if [ -f $2/DEBIAN/postrm ] ; then sudo chmod 555 $2/DEBIAN/postrm ; fi
        dpkg -b $2 "$2".deb
        #sudo rm -R $2
        sudo chmod -R 777 "$2"
        if [ -f "$2.deb" ] ; then sudo chmod 777 "$2.deb" ; fi
    ;;
    *)
        error1
        exit 4
    ;;
esac
