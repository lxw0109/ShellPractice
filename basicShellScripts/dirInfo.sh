#!/bin/bash
#File: dirInfo.sh
#Author: lxw
#Time: 2014-02-28

# Both Method1 and Method2 is OK.
###Method 1 ###
#The following part in set -x...set +x is important.
#How to deal with the VARIABLES that is null value. ----->  [ -z STRING ]
#set -x
#if [ "" == "$1" ]	#NOTE: This is OK. But [ "" == $1 ] is NOT ALWAYS OK.
if [ -z "$1" ]
then
	DIR=$(pwd)
elif [ -d "$1" ]
then
	DIR=$1
	echo "\$1 is $DIR"	# Means "$1 is ..."
else
	#SHELL seems to be similar to PYTHON in some way, both of the two programming language are using INDENT to make code parts. However, SHELL doesn't have to follow the INDENT while PYTHON does have to.
	echo "Illegal Directory! The Current Work Directory will be used!"
	DIR=$(pwd)
fi
#set +x

###Method 2 ###
#set -x
#DIR=${1:-"$(pwd)"}
#if [ ! -d "$DIR" ]
#then
#	echo "Illegal Directory! The Current Work Directory will be used!"
#	DIR=$(pwd)
#fi	
#set +x

while true #OK
do
	############################################################################	
	# 'read var' and 'var=${var:-"default value"} can be seen as a COMBINATION.
	if [ -z "$DIR" ]
	then
		read -p "Please input a Direcotry you want to check:" DIR
	fi
	# READ is here, the following line is here
	DIR=${DIR:-"$(pwd)"}
	echo "lxw : $DIR"

	if [ ! -d "$DIR" ]
	then
		echo "Illegal Directory! The Current Work Directory will be used!"
		DIR="$(pwd)"
	fi
	############################################################################	

	echo "The Directory $DIR is like this:"
	ls $DIR
	
	#read -p: If there are some 'Escape Characters' in the prompt string, there will be something unexpected.
	#read -p "\nWhich of the following information do you want?\nSIZE\tPERMISSION\tOWNDER\tGROUP\tAll of Above\n" INFO
	echo -e "\nWhich of the following information do you want?\n1:SIZE\t2:PERMISSION\t3:OWNDER\t4:GROUP\t5:All of Above" 

	read INFO	#can not be like 'read $INFO'
	INFO=${INFO:-"PERMISSION"}
	echo $INFO

	case "$INFO" in
	"SIZE" | "1")
		ls -l "$DIR" | awk 'NR!=1 { printf "%-25s\t%-10s\n", $9, $5 }'
		;;
	"PERMISSION" | "2")
		ls -l "$DIR" | awk 'NR!=1 { printf "%-25s\t%-20s\n", $9, $1 }'
		;;
	"OWNER" | "3")
		ls -l "$DIR" | awk 'NR!=1 { printf "%-25s\t%-10s\n", $9, $3 }'
		;;
	"GROUP"|"4")
		ls -l "$DIR" | awk 'NR!=1 { printf "%-25s\t%-10s\n", $9, $4 }'
		;;
	"All of Above" | "5")
		ls -l "$DIR" | awk 'NR!=1 { printf "%-25s\t%-10s\t%-20s\t%-10s\t%-10s\n", $9, $5, $1, $3, $4}'
		;;
	*)
		echo "Illegal Input,Please Examin your input!"
		;;
	esac
	DIR=""
done

#BUGS(2014-02-25)
#. and .. are OK. However ~ is NOT OK.