#!/bin/bash

# This script uses spindump for measuring fanspeed
# It's only tested on OS X "El Capitan"
#
# 2016-01-14 Kai Laufer

PASSWORD=${1}
FAN_SPEED=$(echo "${PASSWORD}" | sudo -S spindump -notarget 1 -nofile | grep "Fan speed" | cut -f 2 -d ":" | sed "s/ rpm//g" | sed "s/ //g")
echo "${FAN_SPEED}"
