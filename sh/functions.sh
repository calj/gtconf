########################################################
#                                                      #
#       GEEKTIPS.ORG EASY CONFIGURATION SYSTEM         #
#                                                      #
#                      BETA 0.1                        #
#                                                      #
#               sh compatible functions                #
#                                                      #
########################################################

# CHECK DEPENDANCES
function require()
{
    while [ "$1" != "" ]; do
	which $1 2>&1 > /dev/null || return 1
	shift
    done
    return 0
}

# concat_dir $ORDER $ORIGNAL_PATH ["path/to/pack", ...]
function concat_dir()
{
    _ORDER_="$1"
    _PATH_="$2"
    while [ "$3" != "" ]; do
	if [ -d $3 ]; then
	    echo $_PATH_ | grep -E "(^|:)$2/?(:|\$)" > /dev/null
	    if [ $? -ne 0 ]; then
		if [ "$_ORDER_" = "before" ]; then
		    _PATH_=$3:$_PATH_
		else
		    _PATH_=$_PATH_:$3
		fi
	    fi
	fi
	shift
    done
    echo $_PATH_
}

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
if require 'ssh'; then
    function push_key ()
    {
	KEYF=''

	for f in ~/.ssh/id_dsa.pub ~/.ssh/id_rsa.pub; do
	    test -f $f && KEYF=$f
	done

	if [ "$KEYF" = '' ]; then
	    echo "You have to generate a key first, try ssh-keygen"
	    return
	fi

	if [ -n "$1" ]; then
	    cat $KEYF | ssh "$1" "[ ! -d ~/.ssh ] && mkdir ~/.ssh; cat - >> ~/.ssh/authorized_keys"
	    ssh "$1" w
	    echo "If your password was asked once it's DONE"
	fi
    }
fi

# COLOR
if require 'sed'; then
    function color ()
    {
	sed 's/\('$1'\)/'$lred'\1'$std'/ig'
    }
fi

# COPY TO CLIPBOARD EASILY USING XCLIP
if require 'xclip'; then
    function copy ()
    {
	echo -n $@ | xclip
    }
fi

# CALCULATOR
if require 'bc'; then
    function calc ()
    {
	echo "$*" | bc -l
    }
fi

# MAKE A TARBALL
if require 'tar'; then
    function mktar ()
    {
	tar cvjf "$1.tar.bz2" $@
    }
fi

# CLEAN A DIRECTORY
function clean ()
{
    rm -f .*~
    rm -f *~
    rm -f .\#*
    rm -f \#*\#

    return 0
}

# SSH TO ANY SERV YOU WANT: `sshanyserv ip login`
if require 'ssh'; then
    function ssh_anyserv ()
    {
	user=$USER
	computer=$1
	
	if [ "$2" != "" ]; then
	    user="$2"
	fi
	
	echo ssh "$user"@"$computer"
	ssh "$user"@"$computer"
    }
fi

# DISABLE TIMEOUTS
if require 'echo' 'true' 'sleep'; then
    function donttimeoutme()
    {
	while true;do echo -n "\a"; sleep 60; done &
    }
fi

# INFINITY LOOP (does infinity the command)
function infinity_loop()
{
    while true; do $@;done
}

if require 'md5sum' 'cut'; then
# GENERATE A DIGEST EASILY
    function digest_generator()
    {
	echo -n "user:"    &&  read DIGEST_USER
	echo -n "digest:"  &&  read DIGEST_DIGEST
	echo -n "pass:"    &&  read DIGEST_PASS

	ENCODED_PASS=$(echo -n $DIGEST_USER:$DIGEST_DIGEST:$DIGEST_PASS | md5sum | cut -d' ' -f1)
	echo $DIGEST_USER:$DIGEST_DIGEST:$ENCODED_PASS
    }
fi


# RELOAD THE SHRC
function re()
{
    if require 'cut'; then
	for i in `alias | cut -d'=' -f1`;do
	    [ "$i" != "-"   ] &&
	    [ "$i" != "']'" ] &&
	    alias "$i"="$i"
	done
    fi

    source /etc/profile
}
