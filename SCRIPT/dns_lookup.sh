#!/bin/bash

# DNS lookup
domain=$(zenity --entry --title="DNS Lookup" --text="Enter the domain name:" --entry-text="example.com")
if [ -z "$domain" ]; then
    zenity --error --text="No domain entered. Exiting."
    exit 1
fi

dns_result=$(nslookup "$domain")
zenity --info --title="DNS Lookup Results" --text="DNS Lookup for $domain:\n$dns_result"
