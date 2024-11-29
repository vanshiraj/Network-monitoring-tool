#!/bin/bash

# Capture network packets
interface=$(zenity --entry --title="Packet Capture" --text="Enter the network interface for capturing packets:" --entry-text="eth0")
if [ -z "$interface" ]; then
    zenity --error --text="No interface entered. Exiting."
    exit 1
fi

sudo tcpdump -i "$interface" -c 10 > /tmp/packet_capture.log
capture_output=$(cat /tmp/packet_capture.log)
zenity --info --title="Packet Capture" --text="Captured Packets:\n$capture_output"
