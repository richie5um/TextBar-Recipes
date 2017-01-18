#!/bin/sh

MOUNTS=`/sbin/mount \
    | egrep '^/' \
    | fgrep ' on /Volumes' \
    | wc -l \
    | tr -dc '[0-9]'`

#echo "Mounts: $MOUNTS"
echo "<html><font face=\"helveticaneue-ultralight\">" Mounts: $MOUNTS"</font></html>"
