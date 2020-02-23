#!/bin/sh
# This will pull data from a NightScout Continuous Glucose Monitoring website.
# The Unicode stuff is rough, but it works.
# See: http://www.nightscout.info/

# CONFIGURATION
# Replace this URL with the URL of your NightScout setup
NS_URL=https://cgmtest.herokuapp.com
DATA=$(curl --silent --fail ${NS_URL}/api/v1/entries/current)
VALUE=$(echo $DATA | awk '{print $3}')
DIRECTION=$(echo $DATA | awk '{print $4}' | sed 's/\"//g')
TIME=$(echo $DATA | awk '{print $1}' | date +'%I:%M %p')
# This maps the direction strings to nice Unicode characters
DIRECTION=$(echo $DIRECTION | sed 's/TripleUp/⤊/')
DIRECTION=$(echo $DIRECTION | sed 's/DoubleUp/⇈/')
DIRECTION=$(echo $DIRECTION | sed 's/SingleUp/↑/')
DIRECTION=$(echo $DIRECTION | sed 's/FortyFiveUp/↗/')
DIRECTION=$(echo $DIRECTION | sed 's/Flat/→/')
DIRECTION=$(echo $DIRECTION | sed 's/FortyFiveDown/↘/')
DIRECTION=$(echo $DIRECTION | sed 's/SingleDown/↓/')
DIRECTION=$(echo $DIRECTION | sed 's/DoubleDown/⇊/')
DIRECTION=$(echo $DIRECTION | sed 's/TripleDown/⤋/')
# The end result
echo $VALUE $DIRECTION @ $TIME
