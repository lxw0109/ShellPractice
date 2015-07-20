#/bin/bash
#File: basicShellScripts.sh
#Author: lxw
#Time: 2014-02-28
#Usage:This script is to show the usage of the frequent expressions.
#NOTE: Only use space where it's essential.(e.g. '[ -e a.txt ]') & Don't use it where it's not essential.(e.g. 'y="abc"')

#read & echo
#No need to Decalre the variable name
read -p "Please input your name:" name
echo -e "Hello $name\n"	# -e for '\n'


#date
date1=$(date --date="2 days ago" +%Y-%m-%d)	# '+' is essential, while '-' is just a delimiter.
#date2=$(date --date="1 days ago" +%Y-%m-%d)  #Both of the 2 methods are OK.
date2=$(date --date="1 day ago" +%Y-%m-%d)
date3=$(date +%Y%m%d)

echo "\$date1 is : $date1"
echo "\$date2 is : $date2"
echo "\$date3 is : $date3"


#Arithmetic Operation
var1=2
var2=3
total=$var1*$var2	
echo $total 	# RESULT: '2*3'
total1=$(($var1*$var2))
echo $total1	# RESULT: '6'
declare -i total2=$var1*$var2
echo $total2	# RESULT: '6'

total3=$(expr $var1 \* $var2)	#NOTE: SPACES are ESSENTIAL among EVERY two elements. And '*' must be with '\'
echo $total3	# RESULT: '6'
total4=$(expr 2 \* 3)
echo $total4	# RESULT: '6'
total5=$(expr 4 / 3)
echo $total5	# RESULT: '1'


#if
read -p "Please input (Y/N)" yn
#if [ "$yn" == "Y" || "$yn" == "y" ]	#WRONG
#Both of the following 2 methods is OK.
#if [ "$yn" == "Y" -o "$yn" == "y" ]
if [ "$yn" == "Y" ] || [ "$yn" == "y" ]
then	#NOTE: 'then' must be in a single line. "if [ condition ] then" is NOT OK.
	echo "Y/y"
elif [ "$yn" == "N" -o "$yn" == "n" ]
then
	echo "N/n"
else
	echo "Wrong Input"
fi


#function & case
repeat(){
	#$0 is filename, but $1 $2 NOT 'bash filename $1 $2', BUT the parameters delivered to the function repeat(). Here,it refers to "What\'s" "YOUR" and "NAME"
	echo "I don't know $0 $1 $2 $3"
}
echo "\$0=$0, \$1=$1, \$2=$2"	#'bash filename $1 $2'
repeat What\'s your name

function printit(){
	echo -n "Your choice is : "	# -n means 'WITHOUT NEWLINE'. echo is with NEWLINE by default.
}

echo -e "1:One\t2:Two\t3:Three"
read choice
case "$choice" in
	"1"|"One")
		printit; echo "$choice"		# ';' is used here to seperate the more than one expressions. NOT RECOMMENDED THIS USAGE.
		;;
	"2"|"Two")
		#NOTE: NOT printit() but printit
		printit
		echo "$choice"
		;;
	"3"|"three")
		printit
		echo "$choice"
		;;
	*)
		printit
		echo "stupid"
		;;
esac

#break is OK in shell.

#while do done
#NOTE: 'yn = ""' is WRONG.
yn=""
while [ "$yn" != "yes" ] && [ "$yn" != "YES" ]
do
	read -p "please input yes/YES to stop this program : " yn
done
echo "ok, while is over"


#until do done
#NOTE: 'until [ "$yn" = "no" || "$yn" = "NO" ]' is WRONG.
until [ "$yn" == "no" ] || [ "$yn" == "NO" ]
do
	read -p "Please input no/NO to stop this program : " yn
done
echo "ok, until is over"


#for...do...done
#for animal in dog cat elephant		# Without " is  OK as well
for animal in "dog" "cat" "elephant"
do
	echo "There are ${animal}s..."	# add s to $animal
done

#users=$(cut -d ':' -f 1 /etc/passwd)	# GET USERS INFORMATION.
users=$(tail -n 5 /etc/passwd|cut -d ":" -f 1)
echo "users: $users"
for user in $users
do
	#id $user|less
	id $user
done

filelist=$(ls)
for file in $filelist
do
	echo "$file"
done


#for...do...done FOR NUMBERS
read -p "1+2+3+...+YOUR INPUT : " nu
s=0
for((i=1; i<=$nu; ++i))	#NOT i=1; $i<=$nu; ++$i.	'$' is not hoped here.
do
	s=$(($s+$i))	#$(()) for ARITHMETIC OPERATIONS
	#NOT "$s=$(($s+$i))": the first "$" is not hoped here.
done
echo "The SUM is : $s"


#array
echo "ARRAY"
#METHOD1
declare -a array
array[1]="sm"
array[2]="bm"
array[3]="nm"
echo "1:${array[0]}"
echo "2:$array[1]"		# OUTPUT:'[1]'. array is not a variable, so $array==''	HINT:'{}' is essential.
echo "3:${array[1]}"	# OK
echo "4:${array[4]}"	# NOTHING SHOWS
echo "5:${array}"		# NOTHING SHOWS

#METHOD2
array1=('mon' 'tue' 'wed' 'thu' 'fri' 'sat' 'sun')	# The delimiter(' ') CANNOT be replaced by ','
for var in ${array1[@]}	# ${array1[@]}: All elements of the ARRAY.
do
	echo -en "$var\t"
done
echo ""		#newline

#METHOD3
array2=([0]='mon' [4]='fri' [2]='wed')
echo "Number of elements is : ${#array2[@]}"	# ${#array2[@]}: The number of elements in the ARRAY.
for var in ${array2[@]}
do
	echo -en "$var\t"
done
echo ""		#newline
echo ${array2[@]}

#DEMO1
unset array2[2]		# delete array2[2]
#unset array2[@]		# delete all elements
declare -i num=${#array2[@]}
echo "num is $num"
for((i=0; i<$num; ++i))
do
	echo -en "${array2[i]}\t"
done
echo ""		#newline
#NOTE the 'for' loop in METHOD3 and DEMO1. METHOD3 is expected.

#DEMO2
sports=($(cat sports.txt|tr '\n' ' '))	# Note this method to set values for array.
echo ${sports[@]}

echo ${sports[@]:2}		# ELEMENTS from the THIRD to the end.
echo ${sports[@]:3:2}	# TWO ELEMENTS after the FOURTH element.