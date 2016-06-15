#!/bin/bash

vms=$(/usr/local/bin/VBoxManage list vms | awk -F\" '{a[i++]=$2};END{for (j=i-1; j>=0;) print a[j--]}')
vms_run=$(/usr/local/bin/VBoxManage list runningvms | awk -F\" '{a[i++]=$2};END{for (j=i-1; j>=0;) print a[j--]}')

# set this to use line feeds instaed of spaces as selector
IFS=$(echo -en "\n\b")

echo
for vm in $vms
do
    state=''
    
    for vm_r in $vms_run
    do
	if [ "$vm" == "$vm_r" ] 
	then
	    state='\e[32m'
	fi
    done
    
    echo -e "$state$vm"
    echo
    
done