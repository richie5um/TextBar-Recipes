#!/bin/bash

if [ ! -z "$2" ]; then
    #INDEX=`cd "$2" ; git status --short 2> /dev/null`
    INDEX=`cd "$2" ; git -c color.status=always status --short 2> /dev/null`    

    STAGED=$(echo "$INDEX" | grep -Ev '^\?\? ' | wc -l | tr -d " \t")
    UNSTAGED=$(echo "$INDEX" | grep -E '^\?\? ' | wc -l | tr -d " \t")

    if [ ! -z "$1" ]; then
        echo -n "$1 "
    fi
    echo -e "\e[92m●\e[39m$STAGED \e[91m●\e[39m$UNSTAGED"
else
    echo "Invalid Path"
fi
echo "$INDEX"
