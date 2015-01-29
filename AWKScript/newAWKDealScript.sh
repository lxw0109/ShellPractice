#!/bin/bash
#File: newAWKDealScript.sh
#Author: lxw
#Time: 2014-08-12
#Instruction:	Count the number of the IPv4 addresses of each country listed. 
#				Count the number of the addresses which belong to class C.

if [ ! -f "$1" ]
then
	echo "Usage: \"bash fileName dataFile\""
	exit 1
fi

#cat "$1"|awk 'BEGIN{FS="|"} $2 ~ /^[A-Z][A-Z]$/ && $3=="ipv4" {a[$2]+=$5; len=split($4, arr, "."); if(arr[1] > 191 && arr[1] < 224) b[$2]+=$5;} END{for(i in a) printf("%-5s%-10d%-10d\n", i, a[i], b[i]/256)}'|sort -r -n -k 2 > output

cat "$1"|awk 'BEGIN{FS="|"} $2 ~ /^[A-Z][A-Z]$/ && $3=="ipv4" {a[$2]+=$5} END{for(i in a) printf("%-5s%-10d%-10d\n", i, a[i], a[i]/256)}'|sort -r -n -k 2 > output
