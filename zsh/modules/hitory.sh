########################################################
#                                                      #
#       GEEKTIPS.ORG EASY CONFIGURATION SYSTEM         #
#                                                      #
#                      BETA 0.1                        #
#                                                      #
#               EPITA useful zsh functions             #
#                                                      #
########################################################



SAVEHIST=1000
HISTSIZE=1000
HISTFILE=~/.zsh_history

# Share history with all shell
#setopt share_history

#
setopt csh_junkie_history

# Remove duplicate commands in history
setopt hist_ignore_dups

#
setopt hist_allow_clobber

# Remove consecutive blanks in history
setopt hist_reduce_blanks

# Leading spaces are ignored in history
setopt histignorespace
