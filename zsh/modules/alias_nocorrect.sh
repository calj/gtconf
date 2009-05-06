########################################################
#                                                      #
#       GEEKTIPS.ORG EASY CONFIGURATION SYSTEM         #
#                                                      #
#                      BETA 0.1                        #
#                                                      #
#Disable auto-correction for binaries in $GT_NOCORRECT #
########################################################


GT_NOCORRECT=$GT_NOCORRECT"mv cp mkdir ln touch"

for i in $(echo $GT_NOCORRECT);do

    alias "$i=nocorrect $i"

done

