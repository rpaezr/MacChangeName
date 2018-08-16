#!/bin/bash

# THIS SCRIPT IS PROVIDED BY THE AUTHOR JOHN HAWKINS "AS IS" CONDITION.
# PERSONS OR PARTY THAT USE THIS SCRIPT ASSUMES RESPONSIBILITY FOR ANY DAMAGES 
# THAT MAY OCCUR AS A RESULT OF THIS SCRIPT.  

# This script will gather the first and last name of the owner and 
# store it in JAMF under Computer Name (First Name Last Name).    
# Author: John Hawkins (john.hawkins.contractor@bbva.com / john.hawkins@pomeroy.com / johnhawkins3d@gmail.com
# Date created: 04/04/2017 - Date Modified: 06/07/2017

# User is prompted with a notification telling them that their first and last name needs to be recorded
UPDATE=$(/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper -windowType utility -icon /Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/Resources/Message.png -heading "BBVA Compass IT Notice" -description "The BBVA Administrator has requested that you verify the owner of this comptuer.  You will be asked to input your First and Last Name." -button1 "Proceed" -button2 "Cancel" -cancelButton "2" -icon /Library/User\ Pictures/BBVA/bbvalogo.jpg)

if [ "$UPDATE" == "0" ]; then

# User is prompted to enter their first name
FirstName=`/usr/bin/osascript <<EOT

	tell application "System Events"
    	activate
    	set FirstName to text returned of (display dialog "Please enter your First Name" default answer "")
	end tell
EOT`
echo $FirstName


# User is prompted to enter their last name
LastName=`/usr/bin/osascript <<EOT

tell application "System Events"

    activate
    set LastName to text returned of (display dialog "Please enter your Last Name" default answer "")
end tell
EOT`
echo $LastName

	# The first name and last name variables are updated for the ComputerName, LocalHostName, and HostName fields
	scutil --set ComputerName "$FirstName $LastName"
	scutil --set LocalHostName "$FirstName$LastName"
	scutil --set HostName "$FirstName's Mac"

	# An inventory status update is performed and sent to JAMF
	jamf recon

	# Notification informing the user afte the task has been completed
	osascript -e 'display notification "Thank you for completing this procedure." with title "Reminder"'
	
# Action to be taken if the user selects "No"	
elif [ "$UPDATE" == "1" ]; then
	# Exits if user cancels
	exit

fi

exit
