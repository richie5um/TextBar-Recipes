#!/bin/sh

SSID=$( { networksetup -getairportnetwork en0 | sed 's/.*[:] //'; }  2>&1 )
SSID=`echo $SSID | sed 's/You are not associated with an AirPort network. Wi-Fi power is currently off./WiFi Off/'`

if [[ $SSID == *"WiFi Off"* ]] ; then # Faster scan if wifi not available
    echo "\e[41m  $SSID  "
    echo "----TEXTBAR----"
    echo "REFRESH=5"
else
    echo $SSID
fi