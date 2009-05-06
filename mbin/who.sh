#!/bin/sh
## who.sh for  in /u/a1/cavala_p/tools
##
## Started on  Tue Oct 17 01:41:11 2006 philippe cavalaria
## Last update Tue Oct 17 01:43:51 2006 philippe cavalaria
##

found=0

list="noel_b leliev_j prigen_k haye_p meulie_c houegb_j hate_r gafsi_k hu_w cavala_p tobo_n ben-ga_s colaut_j"
red='[0;31m';    lred='[1;31m'
green='[0;32m';  lgreen='[1;32m'
yellow='[0;33m'; lyellow='[1;33m'
blue='[0;34m';   lblue='[1;34m'
purple='[0;35m'; lpurple='[1;35m'
cyan='[0;36m';   lcyan='[1;36m'
grey='[0;37m';   lgrey='[1;37m'
white='[0;38m';  lwhite='[1;38m'
std='[m'

for i in $list; do
    where=`ns_who "$i"`
    if [ "$where" != "" ]; then
	found=1
	echo "-> ${lgrey}${where}${std}"
    fi
done

if [ $found -eq 0 ]; then
    echo "Personne :("
    return 1
fi
