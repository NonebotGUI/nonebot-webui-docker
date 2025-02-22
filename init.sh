#!/bin/sh

if [ -z "$(ls -A /app/data)" ]; then
    cp -r /app/* /data/
fi
sh /data/entrypoint.sh