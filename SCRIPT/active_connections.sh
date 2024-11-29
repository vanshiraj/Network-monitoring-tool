#!/bin/bash

# Display all active network connections
echo "Active Network Connections:"

# Use 'ss' command to list all active TCP and UDP connections
# Show: Protocol, Local Address:Port, Remote Address:Port, State
ss -tuln | awk 'NR>1 {print $1, $5, $6, $7}' | while read line; do
    # Display the formatted output for each active connection
    echo "$line"
done

# For more detailed output, you can also include connection statistics
echo -e "\nDetailed Connection Statistics:"
ss -s
