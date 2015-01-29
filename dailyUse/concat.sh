#!/bin/bash
#File: concat.sh
#Author: lxw
#Time: 2014-03-09
#Usage: Concat the files(*.py) in the current directory into a single file.

# Whether there is a file named result
#[ -e result ] && echo "There is already a file named result";echo "EXIT";exit 0	# ';' is not OK here
if [ -e result ]
then
	echo "There is already a file named result"
	echo "EXIT"
	exit 0
fi

touch result
filelist=$(ls *.py)
for file in $filelist
do
	echo "##################$file##################" >> result
	echo "" >> result
	cat $file >> result
	echo "" >> result
	echo "##################OVER#################" >> result
	echo "" >> result
done
