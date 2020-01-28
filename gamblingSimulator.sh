#!/bin/bash
echo "Welcome to Gambling Simulator"

#CONSTANTS
BET=1

#VARIABLES
stake=100
winningAmount=0
looseingAmount=0
winDays=0
loseDays=0

for((i=1;i<=20;i++))
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
		loosingAmount=$(($loosingAmount + 50))
		stake=100
		((loseDays++))
	else
		winningAmount=$(($winningAmount+50))
		stake=100
		((winDays++))
	fi
done

if [ $winningAmount -gt $loosingAmount ]
then
	echo  "After 20 days of playing, you WON ₹$(($winningAmount - $loosingAmount))"
elif [ $winningAmount -lt $loosingAmount ]
then
	echo "After 20 days of playing, you LOST ₹$(($loosingAmount - $winningAmount))"
else
	echo "You neither lose nor win"
fi

echo Number of days of WON: $winDays
echo Number of days of LOST: $loseDays
echo Total amount WON: $winningAmount
echo Total amount LOST: $loosingAmount

