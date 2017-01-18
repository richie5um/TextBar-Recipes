#!/bin/bash

echo "CrashPlan"
#tail -n100 /Library/Logs/CrashPlan/backup_files.log.0 | grep ' /' | tail -n10 | cut -d' ' -f2,3,7- | rev | cut -d' ' -f3- | rev
tail -n100 /Library/Logs/CrashPlan/backup_files.log.0 | sed -n -E 's/^I (.*) [0-9]+ [a-z0-9]+ [0-9] (.*) \([0-9]+\) \[.*\]$/\1 \2/p' | tail -n10
