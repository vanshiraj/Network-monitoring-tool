#!/bin/bash

# Prompt the user for the target IP address
target_ip=$(zenity --entry --title="Port Scanner" --text="Enter the target IP address:" --entry-text="192.168.1.1")
if [ -z "$target_ip" ]; then
    zenity --error --text="No IP address entered. Exiting."
    exit 1
fi

# Prompt the user for the starting port number
start_port=$(zenity --entry --title="Port Scanner" --text="Enter the starting port number:" --entry-text="1")
if [ -z "$start_port" ]; then
    zenity --error --text="No start port entered. Exiting."
    exit 1
fi

# Prompt the user for the ending port number
end_port=$(zenity --entry --title="Port Scanner" --text="Enter the ending port number:" --entry-text="1024")
if [ -z "$end_port" ]; then
    zenity --error --text="No end port entered. Exiting."
    exit 1
fi

# Run the port scan and collect results
result=$(for port in $(seq $start_port $end_port); do
    nc -zv -w 1 $target_ip $port 2>&1 | grep -E "succeeded|open" &
done)

# Display results to the user
if [ -z "$result" ]; then
    zenity --info --text="No open ports found in the specified range."
else
    zenity --info --text="Open ports found:\n$result"
fi
