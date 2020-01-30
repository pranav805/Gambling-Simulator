#!/bin/bash
echo "Welcome to Gambling Simulator"
echo 
#VARIABLES
stake=100
winningAmount=0
loosingAmount=0
winDays=0
loseDays=0
amountInHand=0

#CONSTANTS
BET=1
NO_OF_DAYS=20
PERCENTAGE=50
WIN=$(($(($PERCENTAGE*$stake/100)) + $stake))
LOSE=$(($stake - $(($PERCENTAGE*$stake/100))))

declare -A luckyOrUnluckyDay
declare -A gamblerWinOrLose

function betWonOrLost(){
	if [ $((RANDOM%2)) -eq 1 ]
	then
		stake=$(($stake + $BET))
  	else
		stake=$(($stake - $BET))
	fi
}

function wonOrLose(){
   if [ $stake -eq $LOSE ]
   then
      loosingAmount=$(($loosingAmount + 50))
		((loseDays++))
      stake=100
      amountInHand=$(($amountInHand - 50))
      gamblerWinOrLose[$1]="LOST"
   else
      winningAmount=$(($winningAmount + 50))
		((winDays++))
      stake=100
		amountInHand=$(($amountInHand + 50))
      gamblerWinOrLose[$1]="WON"
   fi
}

function gamblingGame(){
	for((i=1;i<=$NO_OF_DAYS;i++))
	do
		while [[ $stake -ne $LOSE && $stake -ne $WIN ]]
		do
			betWonOrLost
		done
		wonOrLose $i
		luckyOrUnluckyDay[$i]=$amountInHand
	done

	if [ $winningAmount -gt $loosingAmount ]
	then
		echo "After 20 days of playing, you WON ₹$(($winningAmount - $loosingAmount))"
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
echo
echo "Days: 	   ${!luckyOrUnluckyDay[@]}"
echo "Amount:	   ${luckyOrUnluckyDay[@]}"
echo "Won/Lost:  ${gamblerWinOrLose[@]}"
echo
}

function luckyOrNot(){
for i in ${!luckyOrUnluckyDay[@]}
do
	echo "$i ${luckyOrUnluckyDay[$i]}"
done | sort -k2 $1 | head -1
}

while [ $amountInHand -ge 0 ]
do
	gamblingGame
	echo "Luckiest Day and amount Won Maximum:"
	luckyOrNot -rn
	echo "Unluckiest Day and amount Lost Maximum:"
	luckyOrNot -n
	if [ ${luckyOrUnluckyDay[20]} -ge 0 ]
	then
		read -p "Do you want to continue for next month [y/n]: " result
		if [ $result == "y" ]
		then
			echo "---Next month---"
			winningAmount=0
			loosingAmount=0
			winDays=0
			loseDays=0
			amountInHand=0
		else
			break
		fi
	fi
done
