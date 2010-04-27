########################################################
#                                                      #
#       GEEKTIPS.ORG EASY CONFIGURATION SYSTEM         #
#                                                      #
#                      BETA 0.1                        #
#                                                      #
# Disable globbing for binaries in GT_NOGLOB           #
########################################################

GT_NOGLOB=$GT_NOGLOB" wget ssh calc wget rake"

for $cmd in $(echo $GT_NOGLOB); do
    require $cmd && alias "$cmd=noglob $cmd"
done
