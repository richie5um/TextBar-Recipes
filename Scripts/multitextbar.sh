#!/bin/bash
# some little scripts to use with "TextBar - Mac App" http://www.richsomerfield.com/apps/

while [[ $# -gt 0 ]] && [[ ."$1" = .--* ]] ;
do
    opt="$1";
    shift;              #expose next argument
    case "$opt" in
        "--" ) break 2;;
        "--vpn" )
           VPN="$1"; shift;;
        "--vpn="* )     # alternate format: --vpn=host.on.vpn
           VPN="${opt#*=}";;
         "--vbox" )
            VBOX=true;;
        "--timezone" )
           TIMEZONE="$1"; shift;;
        "--timezone="* )
           TIMEZONE="${opt#*=}";;
        "--timeicon" )
           TIMEICON="$1"; shift;;
        "--timeicon="* )
           TIMEICON="${opt#*=}";;
#         "--withdefault" )
#            WITHDEFAULT="$optional_default";;     #set to some default value
#         "--withdefault=*" )
#            WITHDEFAULT="${opt#*=}";;             #take argument
        *) echo >&2 "Invalid option: $@"; exit 1;;
    esac
done


# show me if the default gateway is reachable and if my vpn connection works!
# ~/bin/multitextbar.sh --vpn=some.place.in.your.vpn.net
if [ -n "$VPN" ]; then
    gw=$(route -n get default 2>/dev/null| awk '/gateway/ {print $2}')
    if [ -z "$gw" ]; then 
            # show gw white on red background
            echo '\e[41m\e[37mgw'
    else 
            # show gw with yellow background if unreachable
            ping -o -n -q -t 1 -c 1 $gw &>/dev/null || echo '\e[43mgw'
    fi 
    if (ping -o -n -q -t 3 -c 3 $VPN &>/dev/null) then
            echo vpn
    else
            echo '\e[41m\e[37mvpn'
    fi

    # show some statistics
    echo "local gateway: $gw"
    echo "vpn gateway for ($VPN): $(route -n get $VPN 2>/dev/null| awk '/gateway/ {print $2}')"
fi


# how many and what virtual boxes are running?
# ~/bin/multitextbar.sh --vbox
if [ -n "$VBOX" ]; then
    VBoxManage list runningvms | awk -F\" '{a[i++]=$2};END{print NR; print "virtual boxes running: " NR;for (j=i-1; j>=0;) print a[j--]}'
fi


# what time is it somewhere else?
# ~/bin/multitextbar.sh --timezone=Australia/Sydney --timeicon="🇦🇺"
if [ -n "$TIMEZONE" ]; then
    DATE=`TZ=$TIMEZONE date +"%k:%M"` ; echo "<html><head><meta charset="utf-8"></head><body><font size=\"4pt\" face=\"helveticaneue-light\">$TIMEICON$DATE</font></body></html>"
fi

