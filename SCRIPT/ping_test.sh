#!/bin/bash

# Ping test
target_ip=$(zenity --entry --title="Ping Test" --text="Enter the target IP address:" --entry-text="8.8.8.8")
if [ -z "$target_ip" ]; then
    zenity --error --text="No IP address entered. Exiting."
    exit 1
fi

ping_result=$(ping -c 4 "$target_ip")
zenity --info --title="Ping Test Results" --text="Ping Results:\n$ping_result"
