#!/bin/bash
#File: awkDealScript.sh
#Author: lxw
#Time: 2014-08-08
#Instruction:	Count the number of the IPv4 addresses of each country listed. 
#				Count the number of the addresses which belong to class C.

if [ ! -f "$1" ]
then
	echo "Usage: \"bash fileName dataFile\""
	exit 1
fi

if [ -f output ]
then
	rm output
fi

#Preprocess:
#while read line
#do
#	echo "$line"|cut -d "|" -f 2,4
#done < "$1"

#Intermediate files.
cat "$1"|awk 'BEGIN{FS="|"}$3 ~ /ipv4/{if($2 != "" && $2 != "*") print $4, $5 > $2;}' OFS="\t"

#Deal with the Intermediate files.
for file in $(ls ??)
do
	#Delete the duplicate IP addresses.
	#Method1:
	awk '!arr[$0]++' "$file" > tempfile
	#Method2:
	#sort $file|uniq > tempfile

	cat tempfile > $file
	rm tempfile	

	#1st
	#echo -en "$file\t\t" >> output
	#echo $(wc -l $file)|cut -d " " -f 1 >> output
	#2nd
	#echo $(wc -l $file)|awk '{printf "%-10s%-10d\t", $2, $1}' >> output
	#Compare '1st' with '2nd' to find which one is faster. 2nd is better? They are almost the same.
	echo -e "$file\t" >> output
	#cat "$file"|awk 'BEGIN{sum=0}{sum+=$2}END{printf "%-10d", sum}' >> output 

	while read line
	do

	done < "$file"

	#DO NOT use the string comparation.	#e.g. 20.0.0.0
	#cat "$file"|awk 'BEGIN{sum=0}{if($2 < "224.0.0.0") if($2 > "192.0.0.0") sum++;}END{printf "%-10d\n", sum}' >> output
	#cat "$file"|awk 'BEGIN{sum=0; FS="."}{if($1 > 191 && $1 < 224) sum++;}END{printf "%-10d\n", sum}' >> output
done
#echo $(wc -l Reserved)|awk '{printf "%-10s%-10d\t", $2, $1}' >> output
#cat Reserved|awk 'BEGIN{sum=0; FS="."}{if($1 > 191 && $1 < 224) sum++;}END{printf "%-10d\n", sum}' >> output

#Interactive.
read -p "Order by which column?(1, 2 or 3)" input
if [ "$input" == "1" ]
then
	sort -n -k 1 output
elif [ "$input" == "2" ]
then
	sort -r -n -k 2 output
else
	sort -r -n -k 3 output
fi

#Delete the intermediate files.
#rm \*	#Delete the * file. There is only one record in this file.
rm ??
