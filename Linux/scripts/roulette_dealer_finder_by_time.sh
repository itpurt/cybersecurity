#!/bin/bash

if [ $# -eq 3 ] ; then
	echo "please enclose time in quotes"
	echo "ex. \"12:00:00 PM\" "
	exit 0
fi


echo "Getting Roulette Dealer Information for $1 @ $2:"
awk  '{print $1" "$2" "$5" "$6}' $1_Dealer_schedule  | grep "$2" 
exit 0
