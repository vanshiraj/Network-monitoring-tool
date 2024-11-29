#!/bin/bash

# Get a list of available network interfaces
interfaces=$(ip -o link show | awk -F': ' '{print $2}')

# Display a dropdown to select an interface
interface=$(zenity --list --title="Select Network Interface" --text="Select the network interface:" --column="Interface" $interfaces)

# Check if an interface was selected
if [ -z "$interface" ]; then
    zenity --error --text="No interface selected. Exiting."
    exit 1
fi

# Check if the interface exists
if ! ip link show "$interface" > /dev/null 2>&1; then
    zenity --error --text="The interface $interface does not exist. Exiting."
    exit 1
fi

# Get bandwidth usage with ifstat
bandwidth=$(ifstat -i "$interface" 1 1 | awk 'NR==3 {print "Received: "$1" bytes/s\nTransmitted: "$2" bytes/s"}')

# Display the result
zenity --info --title="Bandwidth Usage" --text="Bandwidth usage for $interface:\n$bandwidth"
