#!/bin/bash

# Network Monitoring System with Prerequisite Installation
# Author: [Your Name]
# Date: [Date]

# Function to check and install prerequisites
install_prerequisites() {
    echo "Checking for prerequisites..."
    
    # List of required packages
    packages=(ifstat iftop net-tools dnsutils traceroute nmap tcpdump vnstat)

    for pkg in "${packages[@]}"; do
        if ! command -v $pkg &> /dev/null; then
            echo "Installing $pkg..."
            sudo apt update && sudo apt install -y $pkg
        else
            echo "$pkg is already installed."
        fi
    done

    echo "All prerequisites are installed."
}

# Function to display IP address information
display_ip_info() {
    echo "Fetching IP information..."
    ip a | grep 'inet ' | awk '{print "Interface: " $NF "\nIP Address: " $2 "\n"}'
}

# Function to display network interfaces and their statuses
display_network_interfaces() {
    echo "Fetching network interfaces..."
    ip link show
}

# Function to display active network connections
display_active_connections() {
    echo "Fetching active network connections..."
    netstat -tunapl | grep ESTABLISHED
}

# Function to display network traffic statistics
display_network_statistics() {
    echo "Fetching network traffic statistics..."
    ifstat -t 1 1
}

# Function to monitor bandwidth usage
monitor_bandwidth() {
    echo "Monitoring bandwidth usage..."
    iftop -n -t -s 10
}

# Function to perform a ping test
ping_test() {
    read -p "Enter the domain or IP to ping: " target
    ping -c 4 "$target"
}

# Function to perform a DNS lookup
dns_lookup() {
    read -p "Enter the domain to lookup: " domain
    dig "$domain" +short
}

# Function to perform a traceroute
traceroute_test() {
    read -p "Enter the domain or IP for traceroute: " target
    traceroute "$target"
}

# Function to perform a port scan using nmap
port_scan() {
    read -p "Enter the IP or domain to scan for open ports: " target
    nmap -Pn "$target"
}

# Function to capture network packets using tcpdump
packet_capture() {
    read -p "Enter the network interface to capture packets (e.g., eth0): " interface
    echo "Capturing network packets on $interface... Press Ctrl+C to stop."
    sudo tcpdump -i "$interface"
}

# Function to display bandwidth usage using vnstat
show_bandwidth_usage() {
    echo "Displaying bandwidth usage summary..."
    vnstat
}

# Run prerequisite check
install_prerequisites

# Main Menu
while true; do
    clear
    echo "==============================="
    echo "    Network Monitoring System  "
    echo "==============================="
    echo "1. Display IP Address Info"
    echo "2. Show Network Interfaces"
    echo "3. Show Active Connections"
    echo "4. Display Network Statistics"
    echo "5. Monitor Bandwidth Usage"
    echo "6. Perform a Ping Test"
    echo "7. DNS Lookup"
    echo "8. Traceroute Test"
    echo "9. Perform Port Scan"
    echo "10. Capture Network Packets"
    echo "11. Show Bandwidth Usage"
    echo "12. Exit"
    echo "==============================="
    read -p "Select an option [1-12]: " option

    case $option in
        1)
            display_ip_info
            read -p "Press any key to continue..."
            ;;
        2)
            display_network_interfaces
            read -p "Press any key to continue..."
            ;;
        3)
            display_active_connections
            read -p "Press any key to continue..."
            ;;
        4)
            display_network_statistics
            read -p "Press any key to continue..."
            ;;
        5)
            monitor_bandwidth
            read -p "Press any key to continue..."
            ;;
        6)
            ping_test
            read -p "Press any key to continue..."
            ;;
        7)
            dns_lookup
            read -p "Press any key to continue..."
            ;;
        8)
            traceroute_test
            read -p "Press any key to continue..."
            ;;
        9)
            port_scan
            read -p "Press any key to continue..."
            ;;
        10)
            packet_capture
            read -p "Press any key to continue..."
            ;;
        11)
            show_bandwidth_usage
            read -p "Press any key to continue..."
            ;;
        12)
            echo "Exiting Network Monitoring System."
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            read -p "Press any key to continue..."
            ;;
    esac
done