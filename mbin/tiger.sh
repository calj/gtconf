#!/bin/sh

# Copyright Cavalaria philippe [cavala_p@epita.fr]

if [ $# -lt 2 ]; then
    echo "usage: ./tiger.sh files output" 1>&2
    exit 42
fi

~yaka/tiger/tc $@ 2> tmp
<tmp sed 's/^\(.*\):\([0-9]\{1,\}\).\([0-9]\{1,\}\).*: \(.*\)/\1: \2:\3: \4/' > tmp2

cat tmp2


rm -f tmp
rm -f tmp2
