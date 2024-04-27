#!/usr/bin/bash
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# file info
#-------------------------------------------------------------------------------
source ~/data/global.dat
#---------------------------------------------------------------------- function
function fx_disp ()
{
   l=""
   c=0
   while read lin
   do
      d=${lin#$src: }               # strip filename
      if [[ "$d" != "$l" ]]         # do not display duplicates, happens...
      then
         if ((c==0))
         then
            printf "%s" "$d"
         else
            printf ", %s" "$d"
         fi
      fi
      l=$d
      ((c++))
   done
   if [[ $1 == "-n" ]]              # new line ?
   then
      printf ", "
   else
      printf "\n"
   fi
}
#---------------------------------------------------------- command line parsing
case $# in
   1)                               # 1 argument
      src=$1
      ;;
   2)                               # 2 arguments
      if [[ $1 == "-c" ]]
      then                          # option filename
         col=$1
         src=$2
      else                          # filename option
         src=$1
         col=$2
      fi
      ;;
   *)                               # too many arguments
      echo "ERROR! command line arguments"
      exit 1
      ;;
esac
#------------------------------------------------------------------ main program
if [[ $col == "-c" ]]                 # color ?
then
   printf "$Wht"
fi
printf "%s\n" "\$HOME${src#$HOME}"  # substitute environment variable
if [[ $col == "-c" ]]
then
   printf "$nrm"
fi
str=$(ls -ld "$src")                # list info
echo ${str% $src*}
s=${str:0:1}
if [[ $col == "-c" ]]                 # color ?
then
   case $s in
      -)printf "$yel";;
      d)printf "$Mag";;
      l)printf "$RED";;
   esac
fi
mimetype -d "$src" | fx_disp -n     # mimetype info
mimetype -a "$src" | fx_disp
if [[ $col == "-c" ]]                 # color ?
then
   printf "$nrm"
fi
file "$src" | fx_disp               # file info
echo
#-------------------------------------------------------------------------------
