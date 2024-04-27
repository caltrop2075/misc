#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# copy matched icons to ~/temp/icons
# clears directory first
#-------------------------------------------------------------------------------
tgt="$HOME/temp/icons"

fx_help()
{
   echo
   echo "copies icons to \$HOME/temp/icons"
   echo "allows you to find your icon easily"
   echo
   echo "icons.sh [-d,-h] [pattern]"
   echo "pattern \"*pattern*\""
   echo "-d      delete icons in temp"
   echo "        bogus pattern will do the same"
   echo "-h      help"
   echo "        exec with no args"
}

if (( $# > 0 ))
then
   case $1 in
      "-d")
         rm -f "$tgt/"*
         ;;
      "-h")
         fx_help
         ;;
      *)
         clear
         rm -f "$tgt/"*
         find /usr/share/icons -type f -iname "$1" | sort |
         while read src
         do
            nam=${src##*/}
            dir=${src%/*}
            dir=${dir#/usr/share/icons/}
            dir=" ("${dir//\//_}")."

            fil=${src##*/}
            nam=${fil%.*}
            ext=${fil##*.}
            des="$nam$dir$ext"
            echo "$des"
            cp "$src" "$tgt/$des"
         done
      ;;
   esac
else
   fx_help
fi
#-------------------------------------------------------------------------------
