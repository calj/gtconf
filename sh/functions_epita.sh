########################################################
#                                                      #
#       GEEKTIPS.ORG EASY CONFIGURATION SYSTEM         #
#                                                      #
#                      BETA 0.1                        #
#                                                      #
#               EPITA useful zsh functions             #
#                                                      #
########################################################


# DEFINE IF THE COMPUTER IS ON THE EPITA PIE
function isepita ()
{
    ([[ "`echo -n ~ | cut -c 1-3`" = "/u/" ]] || [[ -f ~/$GT_CONF/.isepita ]]) && return 0
    return 1
}

# DEFINE IF THE COMPUTER IS ON THE EPITA RACK PIE
function israck()
{
    case "$HOST" in
	sisco-*|mid-*|sr-*)
	    return 0
	    ;;
	*)
	    return 1
	    ;;
    esac
}

# CHECK THE QUOTA
function guard()
{
    if [ "`quota | grep \*`" != "" ]; then
	echo -n ${lred}
	banner "quota !!!"
	echo -n ${std}
    fi
}

# SSH TO A RANDOMING LINUX COMPUTER.
function sshlinux()
{
    nb=`ns_hwho | grep -i linux | wc -l`
    nb=$((($RANDOM % $nb) + 1))
    pc=$(ns_hwho	 |\
	grep -i linux	 |\
	cut -d ' ' -f 1	 |\
	grep -v '\['	 |\
	cut -d '[' -f 1	 |\
	tail -n $nb	 |\
	head -n 1	 |\
	cut -d ':' -f 3)

    echo "You are connecting to [${lblue}$pc${std}]"...
    ssh "$pc"

    if [[ $? -ne 0 ]];then
	echo "\e[0;31mFAILLED TO CONNECT TO $pc\e[m"
	sshlinux
    fi
}

# SETUP DEATHRALLY ^^

alias dosbox=~/mbin/dosbox" -c 'mount c /goinfre/$USER/DeathRally/' -c 'c:' -c 'dir' -c 'RALLY.EXE'"

function deathsvg ()
{
    cd /goinfre/$USER/

    if [[ -f DeathRally.tar.bz2 ]]; then
	rm -f DeathRally.tar.bz2
    fi

    tar -cvjf DeathRally.tar.bz2 DeathRally
    cp DeathRally.tar.bz2 ~
}

function deathget ()
{
    cp DeathRally.tar.bz2 /goinfre/$USER/
    cd /goinfre/$USER/
    tar -xvjf DeathRally.tar.bz2 DeathRally
    cd DeathRally
}
