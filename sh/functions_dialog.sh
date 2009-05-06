########################################################
#                                                      #
#       GEEKTIPS.ORG EASY CONFIGURATION SYSTEM         #
#                                                      #
#                      BETA 0.1                        #
#                                                      #
# Useful function for making easily sweet menu boxes   #
########################################################

function mydialog ()
{
    echo $@
    while [ "$1" != "" ];do
	echo $1
	echo -----------------
	shift
    done
}

function checklist ()
{
    : ${DIALOG=mydialog}
    : ${DIALOG_OK=0}
    : ${DIALOG_CANCEL=1}
    : ${DIALOG_ESC=255}

    # Get arguments
#    TEXT=\"`echo $1`\"
#    shift


#    OPTIONS=""
#    for i in $(seq $(($#/3)) );do
#	OPTIONS=$OPTIONS\ \"$1\"\ \"$2\"\ \"$3\"
#	shift 3
#    done

    tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
    trap "rm -f $tempfile" 0 1 2 5 15

    echo							\
    $DIALOG							\
	--backtitle \"No Such Organization\"			\
	--title	    \"CHECKLIST BOX\"				\
        --checklist \"Bite\" 20 61 5				\
	"$@"

#	2> $tempfile

#	$OPTIONS						\

    retval=$?

    choice=`cat $tempfile`

    case $retval in

	$DIALOG_OK)
		echo "'$choice' chosen."
		;;

	$DIALOG_CANCEL)
		echo "Cancel pressed."
		;;

	$DIALOG_ESC)
		echo "ESC pressed."
		;;

	*)
		echo "Unexpected return code: $retval (ok would be $DIALOG_OK)"
		;;
    esac
}


function checklist_sample ()
{
#'"Hi, there is a geektips sample checklist"'				\

    checklist	\
		"Apple"		"\"Its an apple.\""				off	\
		"Dog"		"\"No, thats not my dog.\""			on	\
		"Orange"	"\"Yeah, thats juicy.\""			off	\
		"Chicken"	"\"Normally not a pet.\"" 			off	\
		"Cat"    	"\"No, never put a dog and a cat together\""	on	\
		"Fish"   	"\"Cats like fish.\""				on	\
		"Lemon"  	"\"You know how it tastes.\""			on	\


# 		"Option1"	"This is the option1"		on	\
# 		"Option2"	"This is the option2"		off	\
# 		"Option3"	"This is the option3"		off	\
# 		"Option4"	"This is the option4"		off	\
# 		"Option5"	"This is the option5"		on	\


}