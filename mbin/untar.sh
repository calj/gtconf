#! /usr/bin/env sh
##
## Made by cavala_p
## Login   <cavala_p@epita.fr>
##


############################## UNTAR UNDO ##############################
if [ "$untar_undo" = "1" ]; then
    echo "Latest files extracted: "
    echo `cat $(cat /tmp/tar_history)`
    echo -n "About to delete these files. Proceed ? [y/n] "
    zsh -c "read -q && echo -n 'Are you sure ?!? [y/n] ' && read -q" || exit 5
    for file in `cat $(cat /tmp/tar_history)`; do rm -f "$file"; done
    exit 0
fi

################################ UNTAR #################################
usage="Usage: untar tarball [destination]"

if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    echo "$usage"
    exit 1
fi
if [ ! -e "$1" ]; then
    echo "untar: File '$1' doesn't exist."
    exit 2
fi

if [ $# -eq 2 ]; then
    path="$2"
    cd_check=`cd "$2"`
    if [ -n "$cd_check" ]; then
        echo "untar: Can't access destination '$2'."
        exit 3
    fi
else
    path="."
fi

if [ "$UNTAR_DISABLE_CHECK" != "YES" ];then
    case "$1" in
	*.bz2|*.tbz|*.gz|*.tgz|*.tar)

        # Security check: first file is a folder (FIXME)
            case `tar -tf "$1" | head -1` in
		*/*) ;;
		*)
                    echo -n "Warning: Archive seems to contain files in root directory. Proceed ? [y/n] "
                    zsh -c "read -q" || exit 5
                    ;;
            esac

        # Security check: files to be extracted are going to overwrite others
            for file in `tar -tf "$1"`; do test -e "$path/$file" && test_collision=$test_collision" $path/$file"; done
	    if [ -n "$test_collision" ]; then
		echo "Warning: Some files are going to be overwritten:"
		echo "$test_collision"
		echo -n "Extract and overwrite: Proceed ? [y/n] "
		zsh -c "read -q" || exit 6
	    fi
            ;;
    esac
fi

# Backup file list to be extracted
mktemp > /tmp/tar_history
tar -tf "$1" > `cat /tmp/tar_history`

# Extract
case "$1" in
    *.zip)
        echo "Extracting zip archive '$1' to '$path' ..."
        unzip "$1" -d "$path"
        break
        ;;
    *.tar.bz2|*.tbz)
        echo "Extracting tar.bz2 archive '$1' to '$path' ..."
        tar xvj -f "$1" -C "$path"
        break
        ;;
    *.tar.gz|*.tgz)
        echo "Extracting tar.gz archive '$1' to '$path' ..."
        tar xvz -f "$1" -C "$path"
        break
        ;;
    *.tar)
        echo "Extracting tar archive '$1' to '$path' ..."
        tar xv -f "$1" -C "$path"
        break
        ;;
    *.rar)
        echo "Extracting rar archive '$1' to '$path' ..."
        unrar x "$1" "$path"/
        break
        ;;
    *)
        echo "untar: Unrecognized tarball format."
        exit 4
        ;;
esac
