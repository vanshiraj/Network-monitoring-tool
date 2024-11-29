#!/bin/bash

# Display all network interfaces (simple names)
echo "Network Interfaces:"
for interface in $(ls /sys/class/net/); do
    echo $interface
done
