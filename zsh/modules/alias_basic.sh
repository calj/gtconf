########################################################
#                                                      #
#       GEEKTIPS.ORG EASY CONFIGURATION SYSTEM         #
#                                                      #
#                      BETA 0.1                        #
#                                                      #
#Disable auto-correction for binaries in $GT_NOCORRECT #
########################################################

alias rm='rm -i'
alias l="ls -lh"
alias ll=l
alias la="l -a"
alias lsd="ls -d */"
alias df='df -h'
alias '.'="source" # or: alias '.'='pwd'
alias 'cd..'='cd ..'
alias 'cd-'='cd -'
alias 'p'="cd -"
alias '..'='cd ..'
alias ...='cd ../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -- '-'="popd"
alias -- '+'="pushd"

require "md5sum" && alias md5=md5sum
require "bc"     && alias bc='bc -l'
require "grep"   && alias -g G='| grep -Iin'

if require "svn"; then
    alias svn=$GT_DIR/scripts/colorsvn
    compdef colorsvn=svn
fi

if require "less"; then
    alias less='less -r'
    alias -g L='| less'
fi


if require "emacs"; then
    alias e='emacs'
    alias qe='emacs -nw -q'
fi

alias untar=$GT_DIR/mbin/untar.sh
alias untar_undo="untar_undo=1 $GT_DIR/mbin/untar.sh"
alias clean='clean 2> /dev/null'
