# TextBar-Recipes

## What?
Recipes for TextBar app (www.richsomerfield.com/apps).

## Contributions
Please submit pull-requests so that I can add your ideas/scripts.

## Latest Features (New in 1.5.174)

* ANSI escape coloring (see below for an example)
* Multi-line scripts (see below for an example)

## Recipies

### What is my Local IP address?
    ifconfig | grep inet | grep -v inet6 | cut -d" " -f2 | tail -n1

### What is my external IP address?
    curl http://ipinfo.io/ip

### How much disk space am I using?
    df / | awk '{ print $5 }' | tail -n 1

### What is the time in a different country (e.g. UK)?
    UKDATE=\`TZ=GB date +"%H:%M %p"\` ; echo "UK: $UKDATE"

### Is my website running?
    ALIVE=\`curl -Is www.google.com | grep -q "200 OK"\` && echo "Google Alive" || echo "Google Dead"

### Smiley
    echo '😀'
> Easiest way to see other emoji is; Open TextEdit, then "Edit > Emoji & Symbols". Then just copy and paste into TextBar.

### What is my battery charge?
    ioreg -n AppleSmartBattery -r | awk '$1~/Capacity/{c[$1]=$3} END{OFMT="%.2f%%"; max=c["\"MaxCapacity\""]; print (max>0? 100*c["\"CurrentCapacity\""]/max: "?")}'

### Show CPU 'graph'
    $HOME/scripts/CPUSpeed.sh
> Download CPUSpeed.sh to your machine (to ~/scripts), and then add this to TextBar.
> Note: This is fairly basic. It is very slow to use ```top``` to calculate the CPU, but, I've not come across a better way yet.

![CPUSpeed](Screenshots/CPUSpeed.png)

### Show CPU 'graph' - version 2
    $HOME/scripts/cpubar.sh

![CPUBar](Screenshots/CPUBar.png)
> Requires TextBar 1.5.174 or later.

### What song (and artist) is playing in iTunes?
    osascript -e 'if application "iTunes" is running then' -e 'tell application "iTunes"' -e 'if player state = playing then' -e '(get name of current track) & " – " & (get artist of current track)' -e 'else' -e 'return ""' -e 'end if' -e 'end tell' -e 'else' -e 'return ""' -e 'end if'
> If iTunes is running and a song is playing, this will display the current song name and artist name.

### What song (and artist) is playing in Spotify?
    osascript -e 'if application "Spotify" is running then' -e 'tell application "Spotify"' -e 'if player state is playing then' -e 'return "♫ " & (artist of current track as string) & " - " & (name of current track as string)' -e 'end if' -e 'end tell' -e 'end if'
> If Spotify is running and a song is playing, this will display the current song name and artist name.

### Weather
    curl -s 'http://api.openweathermap.org/data/2.5/weather?q=Manchester,UK&units=metric' | python -c 'import sys, json; data=json.load(sys.stdin); print("{} : {:.1f}°C".format(data["weather"][0]["main"], data["main"]["temp"]))'

![Weather](Screenshots/Weather.png)
> Don't refresh too frequently as this service is rate limited.
> You'll need to change "Manchester,UK" to your location, unless you actually live in Manchester :-).

### Unicode Weather
    curl weather.mar.cx/Manchester,_UK | grep "<title>" | cut -d'>' -f2 | cut -d' ' -f1
> This is likely to break as it isn't entirely robust. Edit the location to get your weather.

### Show (Local) Git Repo Status
    $HOME/scripts/git_status.sh TextBar "$HOME/Code/TextBar"

![GitStatus](Screenshots/GitStatus.png)
> Download git_status.sh to your machine (to ~/scripts), and then add this to TextBar.
> Requires TextBar 1.5.174 or later

### Unread Emails in Outlook
    osascript $HOME/scripts/CheckOutlookMail.scpt
> Download CheckOutlookMail.scpt to your machine (to ~/scripts), and then add this to TextBar.

### Next Meeting in Outlook
    osascript $HOME/scripts/OutlookNextMeeting.scpt
> Download OutlookNextMeeting.scpt to your machine (to ~/scripts), and then add this to TextBar.
> Edit OutlookNextMeeting.scpt if you want the text formatted differently.
> Note: This only looks 60 mins into the future. You can edit OutlookNextMeeting.scpt if you want longer.

### Show the clipboard (text)
    pbpaste | sed 's/^[[:space:]]*//;s/[[:space:]]$//' | sed -E 's/^(.{10}).+$/\1.../'
> This looks more complex than you might imagine. It; strips leading and trailing whitespace, displays only 10 chars (and if it exceeds 10 characters, it'll display the ellipsis).
> Obviously, if you 'Copy to Clipboard' on this, you'll get the truncated text - but, as it is already on the clipboard, you don't need to copy it :-).

### Character Count of current clipboard
    pbpaste | wc -c

### Mouse and Keyboard Battery Status
    echo "M: "`ioreg -c BNBMouseDevice | grep '"BatteryPercent" ='  |  sed 's/[^0-9]*//g'`"%"
    echo "B:" `ioreg -c AppleBluetoothHIDKeyboard | grep '"BatteryPercent" ='  | sed 's/[^0-9]*//g'`"%"

![Battery](Screenshots/MouseKeyboardBattery.png)
> Add these as two separate items.

### Stackoverflow Reputation
    json=$(curl -s http://stackoverflow.com/users/flair/22656.json) && echo $json | sed 's/,//g;s/^.*reputation...\([0-9]*\).*$/\1/'
> (replace 22656 by your SO account number)

### Vagrant
    VBoxManage list runningvms | egrep -oh '[a-z]+_default' | awk -F'_' '{print $1}' | paste -s -d", " -
> Show all currently running vagrant boxes (VirtualBox only)

### Show Selected File in Finder
    osascript $HOME/scripts/SelectedFinderFile.scpt
> Download SelectedFinderFile.scpt to your machine (to ~/scripts), and then add this to TextBar.

## ANSI Escape Colors
    echo 'Normal \e[41m Other '
> This is an example.
> Requires TextBar 1.5.174 or later

## Multi-line Scripts
    echo 'Hello' ; echo 'World' ; echo '!'
> Requires TextBar 1.5.174 or later

## HTML
From v1.3.3, TextBar can render _basic_ HTML into your TextBar item. The text must begin with ```<html>```, or end with ```</html>``` - must be in lowercase! - for it to be renderred as HTML.

The HTML support is fairly limited, it supports text and images. The text can be styled using embedded CSS, the images can't. Images should be resized to about 14x14.

### Hello World
    echo '<html><b>Hel</b>lo <i>wor</i>ld</html>'

### Display Image
    echo '<html><img src="http://www......."/></html>'
> You can't resize the image, so make sure it is 14x14 pixels for it to show correctly.

### CSS Styled Text
    cat '$HOME/scripts/apple.html'
> Download apple.html to your machine (to ~/scripts), and then add this to TextBar.

### Is my External drive mounted (with HTML Styled Text)?
    [ -d /Volumes/MyExtDrive ] && echo "<html><font face=\"helveticaneue-thin\"> MyExtDrive mounted</font></html>" || echo "<html><font face=\"helveticaneue-thin\">MyExtDrive <font color=red><b>not</b></font> mounted</font></html>"

## Preferences
> Requires TextBar v1.4.9 (or later)

I'm working on a UI screen for preferences, but, until then you can set the Default Font/Font-Size, and Shell using ```defaults write```

### How to set the default Font
    defaults write com.RichSomerfield.TextBar DefaultFontName -string "HelveticaNeue-UltraLight"
> Requires a restart of the TextBar app

### How to set the default Font-Size
    defaults write com.RichSomerfield.TextBar textBarPreferences.DefaultFontSize -int 10
> Requires a restart of the TextBar app

### How to set the default Shell
    defaults write com.RichSomerfield.TextBar DefaultShell -string "/bin/sh"
> Requires a restart of the TextBar app

### How to set the default Max Width of textbar items
    defaults write com.RichSomerfield.TextBar DefaultMaxWidth -int 100
> Requires TextBar v1.4.47 (or later)

> Requires a restart of the TextBar app

> Note: This is in points. Use '0' for unlimited.

> Note: This only works on OS X Yosemite (10.10)
