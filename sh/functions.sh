########################################################
#                                                      #
#       GEEKTIPS.ORG EASY CONFIGURATION SYSTEM         #
#                                                      #
#                      BETA 0.1                        #
#                                                      #
#               sh compatible functions                #
#                                                      #
########################################################

# LOAD BASIC SHELL COLORS
function load_colors ()
{
    export red='[0;31m'	lred='[1;31m'
    export green='[0;32m'	lgreen='[1;32m'
    export yellow='[0;33m'	lyellow='[1;33m'
    export blue='[0;34m'	lblue='[1;34m'
    export purple='[0;35m'	lpurple='[1;35m'
    export cyan='[0;36m'	lcyan='[1;36m'
    export grey='[0;37m'	lgrey='[1;37m'
    export white='[0;38m'	lwhite='[1;38m'
    export std='[m'
}

# Add a key to the Authorized keys list
function push_key ()
{
    KEYF=''

    for f in '~/.ssh/id_dsa.pub' '~/.ssh/id_rsa.pub'; do
	[ -f $f ] && KEYF=$f
    done

    if [ "$KEYF" -eq '' ]; then
	echo "You have to generate a key first, try ssh-keygen"
	return
    fi

    if [ -n "$1" ]; then
	cat $KEYF | ssh "$1" "cat - >> ~/.ssh/authorized_keys"
	ssh "$1" w
	echo "If your password was asked once it's DONE"
    fi
}

# CALCULATOR
function calc ()
{
    echo "$*" | bc -l
}

# MAKE A TARBALL
function mktar ()
{
    tar cvjf "$1.tar.bz2" $@
}

# CLEAN A DIRECTORY
function clean ()
{
    rm -f .*~
    rm -f *~
    rm -f \#*\#

    return 0
}

# SSH TO ANY SERV YOU WANT: `sshanyserv ip login`
function ssh_anyserv ()
{
    user=$USER
    computer=$1

    if [[ "$2" != "" ]]; then
	user="$2"
    fi

    echo ssh "$user"@"$computer"
    ssh "$user"@"$computer"
}

# DISABLE TIMEOUTS
function donttimeoutme()
{
    while :;do echo -n "\a"; sleep 60; done &
}

# INFINITY LOOP (does infinity the command)
function infinity_loop()
{
    while :;do; $@;done
}

