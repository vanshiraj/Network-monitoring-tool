#!/bin/bash

# Display a heading
echo "====================================="
echo "Network Statistics"
echo "====================================="

# Show active connections
echo -e "\nActive Network Connections:"
ss -tuln

# Show the network interfaces and their status (including bandwidth usage)
echo -e "\nNetwork Interfaces and Bandwidth Usage:"
ifstat -a 1 1

# Display the network interface statistics (packets, errors, dropped, etc.)
echo -e "\nNetwork Interface Statistics (Packets, Errors, etc.):"
netstat -i

# Display detailed network statistics (TCP, UDP, etc.)
echo -e "\nDetailed Network Statistics (TCP/UDP etc.):"
netstat -s

# Display overall network statistics (like total bytes received and sent)
echo -e "\nOverall Network Statistics (Total Bytes Sent/Received):"
cat /proc/net/dev

# Display traffic statistics (daily, monthly, etc.) using vnstat
echo -e "\nTraffic Statistics (Daily, Monthly, etc.) - Requires vnstat:"
vnstat -d
vnstat -m

# Display IP address information for all network interfaces
echo -e "\nIP Address Information:"
ip addr show

# Display routing table
echo -e "\nRouting Table:"
ip route show

# Display DNS information
echo -e "\nDNS Information:"
cat /etc/resolv.conf

# Show the system’s current DNS resolver stats (Optional)
echo -e "\nCurrent DNS Resolver Stats:"
systemd-resolve --statistics

# End of script
echo -e "\n====================================="
echo "Network Statistics Script Completed!"
echo "====================================="
