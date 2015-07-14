#!/usr/bin/python
# Author: Rich Somerfield
# Modified from: https://github.com/kmarchand/iCloudTabsAlfredWorkflow/blob/master/icloudtabs-all.py

import os
import subprocess
import shutil
import tempfile
import plistlib

# RichS: Required so we can redirect the output to stdout (http://stackoverflow.com/a/4546129/6247)
import codecs
import locale
import sys

sys.stdout = codecs.getwriter(locale.getpreferredencoding())(sys.stdout)

def create_temporary_copy(path):
    temp_dir = tempfile.gettempdir()
    temp_path = os.path.join(temp_dir, 'safari_sync_plist_copy.plist')
    shutil.copy2(os.path.expanduser(path), temp_path)
    return temp_path


# make a temp copy of the plist file
temp_plist = create_temporary_copy('~/Library/SyncedPreferences/com.apple.Safari.plist')

# Use plutil to convert binary plist to xml
os.system('plutil -convert xml1 %s' % temp_plist)

# Use plistlib to convert plist XML to a dictionary
info = plistlib.readPlist(temp_plist)

# Clean up (delete) temp file
os.remove(temp_plist)

# Pull out the device elements from the info dict for easier parsing later
devicetabs = []
for uid in info['values'].values():
    try:
        devicetabs.append([uid['value']['DeviceName'], uid['value']['Tabs']])
    except:
        pass

# Get local machine's host and computer names to exclude both from the list
hostname_proc = subprocess.Popen(['scutil --get LocalHostName'], stdout=subprocess.PIPE, shell=True)
(hostname_out, hostname_err) = hostname_proc.communicate()
hostname = hostname_out.strip()

computername_proc = subprocess.Popen(['scutil --get ComputerName'], stdout=subprocess.PIPE, shell=True)
(computername_out, computername_err) = computername_proc.communicate()
computername = computername_out.strip()

# Print out in device separated sections
for device in devicetabs:
    device_name = device[0]
    if device_name not in [hostname, computername.decode("utf-8")]:
        print('%s:' % device_name)
        for tab in device[1]:
            print(u'   * %s <\\e[94m%s\\e[0m>' % (tab['Title'], tab['URL']))
