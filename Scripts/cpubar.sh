#!/bin/bash

free=`top -l 2 | grep "CPU usage" | tail -1 | awk '{printf "%.0f", $7+0}'`
let used=100-$free

printf "CPU "
printf "%2d%% " $used
#printf "["
let count=0;
BAR='▮'
while [ $count -le 100 ]
do
		if [ $used -ge $count ]
		then
	        if [ $used -le 50 ]
	        then
	                printf "\e[32m$BAR" # green
			elif [ $used -le 80 ]
	        then
	                printf "\e[33m$BAR" # yellow
			elif [ $used -le 100 ]
	        then
	                printf "\e[31m$BAR" # red
	        fi
	    else
			#printf "\e[37m$BAR"
			printf "\e[1;30m$BAR"
	    	#printf " "
	    fi
        let count=${count}+10
done
#printf "]"

echo ''

ps xro %cpu=,comm= | while read cpu comm; ((i++<5)); do
    int=$cpu
    int="${int%%.*}"

    echo "$color$cpu% $(basename "$comm")"$'\e[0m'"";
done
