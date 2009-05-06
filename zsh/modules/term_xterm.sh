########################################################
#                                                      #
#       GEEKTIPS.ORG EASY CONFIGURATION SYSTEM         #
#                                                      #
#                      BETA 0.1                        #
#                                                      #
#               EPITA useful zsh functions             #
#                                                      #
########################################################


bindkey "\e[H"		beginning-of-line	# Home (xterm)
bindkey "\e[F"		end-of-line		# End (xterm)


# Xterm resizing-fu. Note that these are utf-8 fonts
if [[ $TERM = "xterm" ]];then
    alias hide='echo -en "\033]50;nil2\007"'
    alias tiny='echo -en "\033]50;-misc-fixed-medium-r-normal--8-80-75-75-c-50-iso10646-1\007"'
    alias small='echo -en "\033]50;6x10\007"'
    alias default='echo -e "\033]50;-misc-fixed-medium-r-semicondensed--13-*-*-*-*-*-iso10646-1\007"'
    alias medium='echo -en "\033]50;-misc-fixed-medium-r-normal--13-120-75-75-c-80-iso10646-1\007"'
    alias large='echo -en "\033]50;-misc-fixed-medium-*-*-*-15-*-*-*-*-*-iso10646-1\007"'


# This is a large font that has a corresponding double-width font for
# CJK and other characters, useful for full-on utf-8 goodness.
    alias larger='echo -en "\033]50;-misc-fixed-medium-r-normal--18-*-*-*-*-*-iso10646-1\007"'
    alias huge='echo -en "\033]50;-misc-fixed-medium-r-normal--20-200-75-75-c-100-iso10646-1\007"'
    alias normal=default
fi


