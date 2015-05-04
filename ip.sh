#!/bin/sh
#OS X: Your local network IP is:
IP=`ifconfig | grep inet | grep -v inet6 | cut -d" " -f2 | tail -n1`
echo "<html><font face=\"helveticaneue-ultralight\">" $IP"</font></html>"
