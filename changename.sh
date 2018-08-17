#!/bin/bash
# THIS SCRIPT WILL GET THE COMPUTER'S SERIAL NUMBER AND USE IT
# TO CHANGE THE HOSTNAME TO "MAC"+{THE SERIAL NUMBER}
############################################################### 

# Get system Serial Number
echo "Getting system serial number..."
NEWNAME="MAC$(system_profiler SPHardwareDataType | awk '/Serial/ {print $4}')"

echo "New Computer name should be:"
echo ${NEWNAME}

echo "Changing computer name now..."

scutil --set HostName ${NEWNAME}
scutil --set LocalHostName ${NEWNAME}
scutil --set ComputerName ${NEWNAME}
dscacheutil -flushcache

# An inventory status update is performed and sent to JAMF
jamf recon

echo "All done"
