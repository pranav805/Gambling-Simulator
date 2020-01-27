#!/bin/bash -x
echo "Welcome to Gambling Simulator"
#CONSTANTS
BET=1

#VARIABLES
stake=100

if [ $((RANDOM%2)) -eq 1 ]
then
	echo Won
	stake=$(($stake+$BET))
else
	echo Lost
	stake=$(($stake-$BET))
fi
