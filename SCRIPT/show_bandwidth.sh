#!/bin/bash

# Function to get network interfaces
get_network_interfaces() {
    # List all network interfaces excluding loopback
    ip -o link show | awk -F': ' '{print $2}' | grep -v "lo"
}

# Function to get current bandwidth usage
get_bandwidth_usage() {
    local interface=$1
    # Get current bandwidth stats from vnstat
    vnstat -i $interface --oneline | awk -F';' '{print "Received: " $3 "\nSent: " $4 "\nTotal: " $5}'
}

# Show the interface selection dialog
INTERFACE=$(zenity --list --title="Select Network Interface" --column="Interface" $(get_network_interfaces))

# If no interface is selected, exit
if [ -z "$INTERFACE" ]; then
    zenity --error --text="No network interface selected. Exiting."
    exit 1
fi

# Main loop to monitor bandwidth usage
while true; do
    # Get current bandwidth usage for the selected interface
    BANDWIDTH=$(get_bandwidth_usage $INTERFACE)
    
    # Display the stats in a Zenity Info box
    zenity --info --title="Bandwidth Usage - $INTERFACE" --text="$BANDWIDTH" --no-wrap --timeout=10
    
    # Wait before checking again
    sleep 10
done
