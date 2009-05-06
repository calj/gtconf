#!/bin/sh
##
## Made by cavala_p
## Login   <cavala_p@epita.fr>
##

url="http://www.meteofrance.com/FR/mameteo/prevVille.jsp?LIEUID=FR75056"
station="Montsouris (75m) Paris"

#------------------------------------------------------------------------------

echo -n "Loading ..."
page=`runsocks curl -s $url | cat -v`

lastupdate=`echo $page | sed -n 's/^.*jour\ le\ \
\([0-9]\{2\}\/[0-9]\{2\}\/[0-9]\{4\}\)\ .\{,10\}\ \
\([0-9]\{2\}h[0-9]\+\).*\
.*$/\1\ at\ \2/p'`

weather=`echo $page | sed -n 's/^.*vision\ pour\ le.\{,50\}<b>\{,30\}\
\(.\{,10\}\ [0-9]\{1,2\}\ .\{,10\}\)\
<\/b>.*$/\1/p'`

sun=`echo $page | sed -n 's/^.*Soleil\ .\{,40\}>Lever\ \
\([0-9]\{2\}h[0-9]\{2\}\)\ -\ Coucher\ \([0-9]\{1,2\}h[0-9]\{1,2\}\)\
.*$/\1\ -\ \2/p'`

tempmin=`echo $page | sed -n 's/^.*\
mini.\{,10\}\(-\?[0-9]\{1,2\}\)\
.*$/\1/p'`

tempmax=`echo $page | sed -n 's/^.*\
maxi.\{,10\}\(-\?[0-9]\{1,2\}\)\
.*$/\1/p'`

printf "\r           \r"
echo "Status for: $station (updated: $lastupdate)"
echo "Prevision: $weather ($sun)  ---->     $tempmin °C / $tempmax °C"
