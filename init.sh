#!/bin/sh

if [ -z "$(ls -A /data)" ]; then
    cp -r /app/* /data/
fi
sh /data/entrypoint.sh