########################################################
#                                                      #
#       GEEKTIPS.ORG EASY CONFIGURATION SYSTEM         #
#                                                      #
#                      BETA 0.1                        #
#                                                      #
# Disable globbing for binaries in GT_NOGLOB           #
########################################################

GT_NOGLOB=$GT_NOGLOB" wget ssh calc wget"

for i in $(echo $GT_NOGLOB);do

    alias "$i=noglob $i"

done

