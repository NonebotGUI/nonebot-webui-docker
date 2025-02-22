#!/bin/sh
ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]; then
    ARCH="amd64"
elif [ "$ARCH" = "aarch64" ]; then
    ARCH="arm64"
else
    echo "Unsupported architecture"
    exit 1
fi
source /data/venv/bin/activate
cd /data/agent
/data/agent/agent-linux-$ARCH &
cd /data/dashboard
/data/dashboard/dashboard-linux-$ARCH