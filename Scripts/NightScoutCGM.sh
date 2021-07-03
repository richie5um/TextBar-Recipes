#!/bin/sh
# This will pull data from a NightScout Continuous Glucose Monitoring website.
# The Unicode stuff is rough, but it works.
# See: http://www.nightscout.info/

# USE
# Call this script with your own NightScout URL to query your setup for data
# and print it out. Example:
#
#    ❯ ./NightScoutCGM.sh https://cgmtest.herokuapp.com
#    166 → @ 09:42 AM
#
# You can supply an option API secret if you're using NightScout in secure
# mode. Example:
#
#    ❯ ./NightScoutCGM.sh https://cgmtest.herokuapp.com 12345789
#    166 → @ 09:42 AM
#
# For more information on securing NightScout see:
#
#   https://nightscout.github.io/nightscout/security/
#
# For more information on using API secret tokens with a secure NightScout
# installation see:
#
#   https://github.com/nightscout/cgm-remote-monitor/wiki/API-v1-Security

API_SECRET=${2:-notdefined}
DATA=$(curl --silent --fail --header "API-SECRET: ${API_SECRET}" ${1}/api/v1/entries/current)
VALUE=$(echo $DATA | awk '{print $3}')
DIRECTION=$(echo $DATA | awk '{print $4}' | sed 's/\"//g')
TIME=$(echo $DATA | awk '{print $1}' | date +'%I:%M %p')
# This maps the direction strings to nice Unicode characters
DIRECTION=$(echo $DIRECTION | sed 's/NONE/⇼/')
DIRECTION=$(echo $DIRECTION | sed 's/TripleUp/⤊/')
DIRECTION=$(echo $DIRECTION | sed 's/DoubleUp/⇈/')
DIRECTION=$(echo $DIRECTION | sed 's/SingleUp/↑/')
DIRECTION=$(echo $DIRECTION | sed 's/FortyFiveUp/↗/')
DIRECTION=$(echo $DIRECTION | sed 's/Flat/→/')
DIRECTION=$(echo $DIRECTION | sed 's/FortyFiveDown/↘/')
DIRECTION=$(echo $DIRECTION | sed 's/SingleDown/↓/')
DIRECTION=$(echo $DIRECTION | sed 's/DoubleDown/⇊/')
DIRECTION=$(echo $DIRECTION | sed 's/TripleDown/⤋/')
DIRECTION=$(echo $DIRECTION | sed 's/NOT COMPUTABLE/—/')
DIRECTION=$(echo $DIRECTION | sed 's/RATE OUT OF RANGE/⚠︎/')
# The end result
echo $VALUE $DIRECTION @ $TIME
