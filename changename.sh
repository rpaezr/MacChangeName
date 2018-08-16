# Get system Serial Number
echo "Getting system serial number..."
#NEWNAME="MacBook"
NEWNAME="$(system_profiler SPHardwareDataType | awk '/Serial/ {print $4}')"
echo "New Computer name should be:"
echo ${NEWNAME}
echo "Changing computer name now..."
sudo scutil --set HostName ${NEWNAME}
sudo scutil --set LocalHostName ${NEWNAME}
sudo scutil --set ComputerName ${NEWNAME}
dscacheutil -flushcache
echo "All done"
