#!/bin/bash
echo "Welcome to Gambling Simulator"

#CONSTANTS
BET=1

#VARIABLES
stake=100
winningAmount=0
losingAmount=0

for (( i=1; i<=20; i++ ))
do
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
		winningAmount=$(($winningAmount+50))
		stake=100
	else
		losingAmount=$(($losingAmount+50))
		stake=100
	fi
done
if  [ $winningAmount -gt  $losingAmount ]
then
	echo "After 20 days of playing, total amount WON is: $(($winningAmount - $losingAmount))"
elif [ $winningAmount -lt  $losingAmount ]
then
	echo "After 20 days of playing, total amount LOST is:  $(($losingAmount - $winningAmount))"
else
	echo "You have neither WON or LOST"
fi
