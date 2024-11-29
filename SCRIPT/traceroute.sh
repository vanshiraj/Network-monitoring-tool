#!/bin/bash

# Traceroute test
target_ip=$(zenity --entry --title="Traceroute Test" --text="Enter the target IP address or domain:" --entry-text="example.com")
if [ -z "$target_ip" ]; then
    zenity --error --text="No target entered. Exiting."
    exit 1
fi

trace_result=$(traceroute "$target_ip")
zenity --info --title="Traceroute Results" --text="Traceroute Results:\n$trace_result"
