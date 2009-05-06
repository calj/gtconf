########################################################
#                                                      #
#       GEEKTIPS.ORG EASY CONFIGURATION SYSTEM         #
#                                                      #
#                      BETA 0.1                        #
#                                                      #
#               EPITA useful zsh functions             #
#                                                      #
########################################################


# Alway init the malloced memory with non-zero bytes
export MALLOC_OPTIONS="J"

# Check if make is linked to gmake:
[[ ! -f $GT_DIR/mbin/make ]]		&& 
where gmake 2>&1 > /dev/null		&&
ln -s `which gmake` $GT_DIR/mbin/make
