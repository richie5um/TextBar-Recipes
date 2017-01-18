#!/bin/bash

if [ ! -z "$1" ]; then
  MYPING=`ping -c 1 "$1" | sed -En '/time=/{s!^.+time=([0-9]*)\..+!\1!;p;}'`
  if [ "$MYPING" == "" ]; then
    printf -v MYPING "%04d" "0"
  else
    printf -v MYPING "%04d" $MYPING
  fi
  echo $MYPING
else
  echo "Missing Server"
fi
