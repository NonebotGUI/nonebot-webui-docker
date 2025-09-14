#!/bin/sh

if [ -z "$(ls -A /data)" ]; then
    cp -r /app/* /data/
    TOKEN=$(head -c 32 /dev/urandom | base64 | tr -dc 'A-Za-z0-9' | head -c 32)
    sed -i "s/\"token\": \".*\"/\"token\": \"$TOKEN\"/g" /data/agent/config.json
    sed -i "s/\"token\": \".*\"/\"token\": \"$TOKEN\"/g" /data/dashboard/config.json
    sed -i "s/\"password\": \".*\"/\"password\": \"$TOKEN\"/g" /data/dashboard/config.json
    sed -i '1,3s/"host": "[^"]*"/"host": "0.0.0.0"/' /data/dashboard/config.json
fi
sh /data/entrypoint.sh