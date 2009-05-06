########################################################
#                                                      #
#       GEEKTIPS.ORG EASY CONFIGURATION SYSTEM         #
#                                                      #
#                      BETA 0.1                        #
#                                                      #
#               EPITA useful zsh functions             #
#                                                      #
########################################################

source $GT_DIR/sh/functions_epita.sh

alias norme=$GT_DIR/mbin/norme.sh

if isepita; then
    [[ -f $GT_DIR/.socksuser ]] && SOCKS_USER=`<$GT_DIR/.socksuser` || SOCKS_USER=$USER

    export http_proxy=http://$SOCKS_USER:`<~/.socks`@proxy.epita.fr:3128
    export  ftp_proxy=$http_proxy
    export NNTPSERVER="news.epita.fr"
    export SOCKS5_USER=$SOCKS_USER
    export SOCKS5_PASSWD=`<~/.socks`
    export TSOCKS_USERNAME=$SOCKS_USER
    export TSOCKS_PASSWORD=`<~/.socks`
    export ftp_proxy="proxy.epita.fr"
    export EMAIL=$SOCKS_USER@epita.fr
    export REPLYTO=$SOCKS_USER@epita.fr
    alias svn='tsocks svn'
    alias ssh='tsocks ssh'

    # CHECK IF WE ARE LOGGED ON THE GATE
    if [[ "$HOST" = "gate-ssh" ]]; then
	ssh neutron
    fi

    alias ]='zlock -immed'
    alias firefox='LD_LIBRARY_PATH="" firefox'
    alias pote=$GT_DIR/mbin/who.sh

    if [[ -g /goinfre/ ]]; then
	if [[ ! -d /goinfre/$USER ]]; then
	    mkdir /goinfre/$USER
	    chmod 700 /goinfre/$USER
	fi
    fi

fi

# {{ KANETON VARIABLES
export KANETON_PYTHON=`which python`
export KANETON_USER="student"
export KANETON_PLATFORM="ibm-pc"
export KANETON_ARCHITECTURE="ia32/educational"

(cat /proc/version | grep Ubuntu) &> /dev/null	&& \
    export KANETON_HOST="ubuntu/ia32"		|| \
    export KANETON_HOST="linux/ia32"

[[ "$KDE_FULL_SESSION" == "true" ]] && \
    export OOO_FORCE_DESKTOP=kde    || \
    export OOO_FORCE_DESKTOP=gnome
# }} KANETON VARIABLES


