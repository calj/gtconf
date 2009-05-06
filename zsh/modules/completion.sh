########################################################
#                                                      #
#       GEEKTIPS.ORG EASY CONFIGURATION SYSTEM         #
#                                                      #
#                      BETA 0.1                        #
#                                                      #
#               EPITA useful zsh functions             #
#                                                      #
########################################################


autoload -U compinit
autoload -U zstyle+
compinit

# Make completion not sensitive to case:
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Add color to completion
LS_COLORS="no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jpg=01;35:*.png=01;35:*.gif=01;35:*.bmp=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.png=01;35:*.mpg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:"
ZLS_COLORS=$LS_COLORS
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Enable verbose, change various messages and add section to completion.
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions'	format $'%{\e[0;31m%}%d%{\e[0m%}'
zstyle ':completion:*:messages'		format $'%{\e[0;31m%}%d%{\e[0m%}'
zstyle ':completion:*:warnings'		format $'%{\e[0;31m%}No matches for: %d%{\e[0m%}'
zstyle ':completion:*:corrections'	format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}'
zstyle ':completion:*' group-name ''

## Menu completion - Hit tab twice to enable menu
zstyle ':completion:*' menu select=long-list select=0

### Ignore useless _* functions (completion functions)
zstyle ':completion:*:functions' ignored-patterns '_*'

# Complete hosts from the known hosts list. ('ssh [TAB]')
if [[ -f "$HOME/.ssh/known_hosts" ]]; then
    local _myhosts >/dev/null
    _myhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} )
    zstyle ':completion:*' hosts $_myhosts
fi
