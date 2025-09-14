#!/bin/sh

if [ -z "$(ls -A /data)" ]; then
    cp -r /app/* /data/
fi
TOKEN=$(head -c 32 /dev/urandom | base64 | tr -dc 'A-Za-z0-9' | head -c 32)
sed -i "s/\"token\": \".*\"/\"token\": \"$TOKEN\"/g" /data/agent/config.json
sed -i "s/\"token\": \".*\"/\"token\": \"$TOKEN\"/g" /data/dashboard/config.json
sed -i "s/\"password\": \".*\"/\"password\": \"$TOKEN\"/g" /data/dashboard/config.json
sh /data/entrypoint.sh