#!/bin/sh

# generate configuration file

./generate-config.sh

# run dnsmasq
echo "Starting dnsmasq..."
nohup dnsmasq &
# and nginx
echo "Starting nginx..."
nginx -g "daemon off;"
