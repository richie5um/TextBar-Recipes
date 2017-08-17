#!/bin/bash

WORKSPACE=~/scripts/isOnline
# list of websites. each website in new line. leave an empty line in the end.
LISTFILE=$WORKSPACE/websites.lst
# List of site/status
SITESTATUS=$WORKSPACE/sitestatus.txt

# Clean up file
if [ -f $SITESTATUS ]; then rm -f $SITESTATUS; fi

# main loop
while read p; do

    response=$(curl -L --write-out %{http_code} --silent --output /dev/null $p)

    if [ $response -eq 200 ] ; then
        # Site up        
        # Increment counter
        SITEUPCOUNT=$[SITEUPCOUNT+1]

        # Add info to SITESTATUS file
        echo -e "$p : \e[32m[ok]\e[0m" >> $SITESTATUS
    else
        # Site Down
        # Increment counter
        SITEDOWNCOUNT=$[SITEDOWNCOUNT+1]

        # Add info to SITESTATUS file
        echo -e "$p : \e[31m[DOWN]\e[0m" >> $SITESTATUS
    fi
done <$LISTFILE

#Prepend the counts to SITESTATUS
echo -e "\e[92m●\e[39m$SITEUPCOUNT \e[91m●\e[39m$SITEDOWNCOUNT\n$(cat $SITESTATUS)" > $SITESTATUS
cat $SITESTATUS