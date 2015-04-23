#!/bin/sh

IP=`ipconfig getifaddr en0`
echo "<html><font face=\"helveticaneue-ultralight\">" $IP"</font></html>"
