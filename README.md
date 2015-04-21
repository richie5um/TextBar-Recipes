# TextBar-Recipies

## What?
Recipies for TextBar app (www.richsomerfield.com/apps).

## Contributions
Please submit pull-requests so that I can add your ideas/scripts.

## Recipies

### What is my Local IP address?
    ipconfig getifaddr en0

### What is my external IP address?
    curl -s -H 'Accept: application/json' ipinfo.io | python -c "import json;import sys;print json.load(sys.stdin)['ip']"

### How much disk space am I using?
    df / | awk '{ print $5 }' | tail -n 1

### What is the time in a different country (e.g. UK)?
    UKDATE=\`TZ=GB date +"%H:%M %p"\` ; echo "UK: $UKDATE"

### Is my website running?
    ALIVE=\`curl -Is www.google.com | grep -q "200 OK"\` && echo "Google Alive" || echo "Google Dead"

### What is my battery charge?
    ioreg -n AppleSmartBattery -r | awk '$1~/Capacity/{c[$1]=$3} END{OFMT="%.2f%%"; max=c["\"MaxCapacity\""]; print (max>0? 100*c["\"CurrentCapacity\""]/max: "?")}'

### What song (and album) is playing in iTunes?
    TRACK=\`osascript -e 'tell application "iTunes"' -e 'set currentTrackName to "[OFF]"' -e 'if player state is playing then' -e 'set currentTrackName to get name of current track & " [" & album of current track & "]"' -e 'end if' -e 'return currentTrackName' -e 'end tell'\` ; echo "> $TRACK"
    
### Unicode Weather
> This is likely to break as it isn't entirely robust. Edit the location to get your weather.
    curl weather.mar.cx/Manchester,_UK | grep "<title>" | cut -d'>' -f2 | cut -d' ' -f1

### Unread Emails in Outlook
> Download CheckOutlookMail.scpt to your machine (to ~/scripts), and then add this to TextBar.
    osascript $HOME/scripts/CheckOutlookMail.scpt
