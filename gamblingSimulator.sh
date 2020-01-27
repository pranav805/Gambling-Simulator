#!/bin/bash -x
echo "Welcome to Gambling Simulator"

#CONSTANTS
BET=1

#VARIABLES
stake=100

while [[ $stake -ne 50 && $stake -ne 150 ]]
do
	if [ $((RANDOM%2)) -eq 1 ]
	then
		stake=$(($stake+$BET))
	else
		stake=$(($stake-$BET))
	fi
done

if [ $stake -eq 50 ]
then
	echo "You have LOST 50% of your stake"
else
	echo "You have WON 50% of your stake"
fi
