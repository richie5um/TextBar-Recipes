#!/bin/bash

CPUSPEED=`cat ~/bin/scripts/.CPUSpeed.txt | tr -d '\n' | sed -E 's/.*(.{16})$/\1/'`

IDLE=`top -n0 -l1 | head -4 | tail -1 | awk '{print $7}' | sed -e 's/%//g'`
if ((`echo "$IDLE > 80.00" | bc` == 1)); then
    CPUSPEED=$CPUSPEED'▁ '
elif ((`echo "$IDLE > 60.00" | bc` == 1)); then
    CPUSPEED=$CPUSPEED'▂ '
elif ((`echo "$IDLE > 40.00" | bc` == 1)); then
    CPUSPEED=$CPUSPEED'▃ '
elif ((`echo "$IDLE > 20.00" | bc` == 1)); then
    CPUSPEED=$CPUSPEED'▅ '
else
    CPUSPEED=$CPUSPEED'▇ '
fi

echo -n "$CPUSPEED"  > ~/bin/scripts/.CPUSpeed.txt
echo -n "$CPUSPEED"
