#!/bin/sh
## test_colors.sh for  in /u/a1/cavala_p
##
## Made by philippe cavalaria
## Login   <cavala_p@epita.fr>
##
## Started on  Mon Oct 16 17:55:12 2006 philippe cavalaria
## Last update Tue Oct 17 01:15:01 2006 philippe cavalaria
##

for attr in 0 1 4 5 7 ; do
    echo "----------------------------------------------------------------"
    printf "ESC[%s;Foreground;Background - \n" $attr
    for fore in 30 31 32 33 34 35 36 37; do
        for back in 40 41 42 43 44 45 46 47; do
            printf '\033[%s;%s;%sm %02s;%02s  ' $attr $fore $back $fore $back
	    printf '\033[0m'
        done
    printf '\n'
    done
    printf '\033[0m'
done