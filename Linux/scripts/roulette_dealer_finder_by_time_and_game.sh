#!/bin/bash

if [ $# -eq 4 ] ; then
	echo "please enclose multi-word arguments  in quotes"
	echo "ex. \"12:00:00 PM\" or \"game of choice\" "
	exit 0
fi

if [  "$3" = "Roulette" ] ; then
  awk  '{print $1" "$2" "$5" "$6}' $2_Dealer_schedule  | grep "$1"
elif [ "$3" = "Black Jack" ] ; then
  awk  '{print $1" "$2" "$3" "$4}' $2_Dealer_schedule  | grep "$1"
elif [ "$3" = "Texas Hold'em" -o  "$3" = "Poker" ] ; then 
  awk  '{print $1" "$2" "$7" "$8}' $2_Dealer_schedule  | grep "$1"
else
#	echo "Unknown game. Try using Roulette, Black Jack, or Texas Hold'em (or Poker) "
  awk  '{print $1" "$2" "$3" "$4" "$5" "$6" "$7" "$8}' $2_Dealer_schedule  | grep "$1"

fi
