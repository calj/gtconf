#!/bin/sh
## cpwww.sh for  in /u/a1/cavala_p/tools
##
## Made by philippe cavalaria
## Login   <cavala_p@epita.fr>
##
## Started on  Tue Oct 17 01:16:49 2006 philippe cavalaria
## Last update Tue Nov 14 01:44:39 2006 philippe cavalaria
##

if [ $1 ]; then
    if [ $1 = "-r" ]; then
	rm -f ~/www/temp/* 2> /dev/null
	rm -f ~/www/temp/.* 2> /dev/null
	echo "Dossier www/temp/ vide."
	exit 0
    elif [ -e $1 ]; then
	echo "Copie de $1 dans ~/www/temp/"
	file="$1"
    else
	echo "Erreur: Le fichier n'existe pas ou ne peut etre ouvert '$1'"
	return 1
    fi
else
    echo "usage: `basename $0 .sh` sourcefile"
    echo "or: '`basename $0 .sh` -r' to erase everything in www/temp/"
    exit 42
fi

echo -n "Executer (y/n) ? "

if zsh -c "read -q"; then
    cp -R $file ~/www/temp/
    chmod 604 ~/www/temp/`basename $file`
    echo "wget http://etudiants.epita.fr/~cavala_p/temp/`basename $file`"
    echo -n "Effacer (y/n) ? "
    if zsh -c "read -q"; then
	rm -f ~/www/temp/`basename $file`
	echo "Done."
    fi
fi
