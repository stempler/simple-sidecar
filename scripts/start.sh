#!/bin/sh

# generate configuration file

./generate-config.sh

# start nginx
echo "Starting nginx..."
cd /
exec /wrapper.sh
