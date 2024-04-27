#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# check links
#-------------------------------------------------------------------------------
# clear
# source ~/data/global.dat

find ~ -type l \! -path "$HOME/.*" -printf "%p|%l\n" | sort |
{
   f=1
   while IFS="|" read lnk tgt
   do
      if [ ! -e "$tgt" ]
      then
         if ((f))
         then
            clear
            title-80.sh -t line "Broken Links"
         fi
         f=0
         printf "%s -> %s\n" "$lnk" "$tgt"
         find ~ -name "${tgt##*/}" | sort
         echo
      fi
   done
   if ((f))
   then
      echo -e "\nno broken links found"
   fi
}
