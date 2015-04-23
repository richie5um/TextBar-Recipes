#!/bin/sh

SSID=`networksetup -getairportnetwork en0 | cut -d':' -f2 | cut -c 2-`
echo "<html><font face=\"helveticaneue-ultralight\">" $SSID"</font></html>"
