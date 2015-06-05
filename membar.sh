#!/bin/bash

# Name:			membar.sh
# Version: 		0.1
# 
# Author: 		Kai Laufer
# Mail: 		mail@kai-laufer.de
#
# Date: 		03.06.2015
# Last modified: 	05.06.2015

GET_USAGE=($(top -l 1 | grep "PhysMem" | sed "s/PhysMem: //g" | sed "s/(//g" | sed "s/)//g" | sed "s/M//g" \
	| sed "s/,//g" | sed "s/\.//g" | sed "s/unused//g" | sed "s/used//g" | sed "s/wired//g"))

for USAGE in ${GET_USAGE[*]}; do
	OLD_USAGE=${USAGE}
	if [[ ${USAGE} == *"G"* ]]; then
		USAGE=$(echo ${USAGE} | sed "s/G//g")
		let USAGE=${USAGE}*1024
		GET_USAGE=($(echo ${GET_USAGE[*]} | sed "s/${OLD_USAGE}/${USAGE}/g"))
	fi
done

let TOTAL_RAM=${GET_USAGE[0]}+${GET_USAGE[2]}
BAR='▮'

# You could also display
# wired mem and free mem
# in percent:
# used=${PERC_LIST[0]}
# wired=${PERC_LIST[1]}
# free=${PERC_LIST[2]}
function in_percent() {
	local IN_PERCENT=$((100*${VALUE}/${TOTAL_RAM}))
	echo ${IN_PERCENT}
}

PERC_LIST=()
for VALUE in ${GET_USAGE[*]}; do
	PERC=$(in_percent)
	PERC_LIST+=(${PERC})
done

if [[ ${PERC_LIST[0]} -lt 40 ]]; then
	OUT="\e[32m${BAR}"
elif [[ ${PERC_LIST[0]} -lt 80 ]]; then
	OUT="\e[33m${BAR}"
else
	OUT="\e[31m${BAR}"
fi

printf "\e[0;30mMEM ${PERC_LIST[0]}%% "

SEQ=${PERC_LIST[0]:0:1}
ROUND_UP=${PERC_LIST[0]:1:2}
if [[ ${ROUND_UP} -ge 5 ]]; then
	let SEQ=SEQ+1
fi

for (( I=0; I < "${SEQ}"; I++ )); do
	printf "${OUT}"
done

RANGE=$((10-${SEQ}))
for (( I=0; I < "${RANGE}"; I++ )); do
	printf "\e[1;30m${BAR}"
done
