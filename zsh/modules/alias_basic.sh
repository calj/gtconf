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

where md5sum &> /dev/null && \
    alias md5=md5sum

where bc &> /dev/null && \
    alias bc='bc -l'

#where svn &> /dev/null && \
#    alias svn=$GT_DIR/scripts/colorsvn && compdef colorsvn=svn

where git &> /dev/null && \
    alias gitpull='git pull serv master' && \
    alias gitpush='git push serv' && \
    alias gitst='git status'

alias -g L='| less'
alias -g G='| grep -Iin'
alias e='emacs'
alias less='less -r'

alias untar=$GT_DIR/mbin/untar.sh
alias untar_undo="untar_undo=1 $GT_DIR/mbin/untar.sh"
alias clean='clean 2> /dev/null'
