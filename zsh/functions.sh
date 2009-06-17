########################################################
#                                                      #
#       GEEKTIPS.ORG EASY CONFIGURATION SYSTEM         #
#                                                      #
#                      BETA 0.1                        #
#                                                      #
#              zsh compatible functions                #
#                                                      #
########################################################


# RELOAD THE ZSHRC
function re ()
{
    for i in `alias | cut -d'=' -f1`;do
	[[ "$i" != "-"   ]] &&
	[[ "$i" != "']'" ]] &&
	unalias $i
    done

    . /etc/profile
    [[ -f ~/.zshrc  ]] && source ~/.zshrc

    autoload -U zrecompile
    [[ -f ~/.zshenv ]] && zrecompile -p ~/.zshenv

    rehash
}


# LIST THE TOP 100 BIGGEST FILES IN A DISK
function biggest_file()
{
    zmodload zsh/stat
    ls -fldh ./**/*(d`stat +device .`OL[1,100])
}

