#!/bin/bash

# Display network interfaces with their current IPv4 and IPv6 addresses
echo "Network Interfaces with IP Addresses:"

for interface in $(ls /sys/class/net/); do
    # Display interface name
    echo -n "$interface: "
    
    # Get IPv4 address
    ipv4=$(ip -4 addr show $interface | grep inet | awk '{print $2}' | cut -d/ -f1)

    
    # Get IPv6 address
    ipv6=$(ip -6 addr show $interface | grep inet6 | awk '{print $2}' | cut -d/ -f1)
    
    # Display IPv4 and IPv6 addresses if available
    if [ -n "$ipv4" ]; then
        echo -n "IPv4: $ipv4 "
            echo ""

    fi
    if [ -n "$ipv6" ]; then
        echo -n "IPv6: $ipv6"
    fi
    echo
done
