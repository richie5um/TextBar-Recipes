#!/bin/bash

WORKSPACE=~/scripts/isOnline
# list of websites. each website in new line. leave an empty line in the end.
# each line can have an url to test and an optional displayname:
# for example:
# http://hostname.com
# hostname.com/testme
# hostname.com:8181
# hostname.com;Pretty Display Name
LISTFILE=$WORKSPACE/websites.lst
# List of site/status
SITESTATUS=$WORKSPACE/sitestatus.txt

SITEUPCOUNT=0
SITEDOWNCOUNT=0

# Clean up file
if [ -f $SITESTATUS ]; then rm -f $SITESTATUS; fi

# main loop
while read p; do

    #Load the website line into an array
    IFS=';' read -ra WWW <<< "$p"
    if [ ${#WWW[@]} -eq 1 ]; then
        DISPLAYNAME=${WWW[0]}
    else
        DISPLAYNAME=${WWW[1]}
    fi

    response=$(curl -L --write-out %{http_code} --silent --output /dev/null ${WWW[0]})

    if [ $response -eq 200 ] ; then
        # Site up        
        # Increment counter
        SITEUPCOUNT=$[SITEUPCOUNT+1]

        # Add info to SITESTATUS file
        echo -e "${DISPLAYNAME} : \e[32m[ok]\e[0m" >> $SITESTATUS
    else
        # Site Down
        # Increment counter
        SITEDOWNCOUNT=$[SITEDOWNCOUNT+1]

        # Add info to SITESTATUS file
        echo -e "${DISPLAYNAME} : \e[31m[DOWN]\e[0m" >> $SITESTATUS
    fi
done <$LISTFILE

#Prepend the counts to SITESTATUS
echo -e "\e[92m●\e[39m$SITEUPCOUNT \e[91m●\e[39m$SITEDOWNCOUNT\n$(cat $SITESTATUS)" > $SITESTATUS
cat $SITESTATUS