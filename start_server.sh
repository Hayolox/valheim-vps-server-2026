#!/bin/bash

export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
export SteamAppId=892970

# Server configuration from environment variables
SERVER_NAME="${SERVER_NAME:-My Valheim Server}"
SERVER_PORT="${SERVER_PORT:-2456}"
WORLD_NAME="${WORLD_NAME:-Dedicated}"
SERVER_PASSWORD="${SERVER_PASSWORD:-secret}"
SERVER_PUBLIC="${SERVER_PUBLIC:-1}"
ADMINS="${ADMINS:-}"

# Setup admin list if ADMINS env variable is set
if [ ! -z "$ADMINS" ]; then
    ADMIN_FILE="/home/steam/.config/unity3d/IronGate/Valheim/adminlist.txt"
    mkdir -p "$(dirname "$ADMIN_FILE")"
    echo "Setting up admin list..."
    echo "$ADMINS" | tr ',' '\n' > "$ADMIN_FILE"
    echo "Admins configured: $(cat "$ADMIN_FILE" | wc -l)"
fi

echo "Starting Valheim Server..."
echo "Server Name: $SERVER_NAME"
echo "World Name: $WORLD_NAME"
echo "Port: $SERVER_PORT"
echo "Public: $SERVER_PUBLIC"
echo ""

./valheim_server.x86_64 \
    -name "$SERVER_NAME" \
    -port $SERVER_PORT \
    -world "$WORLD_NAME" \
    -password "$SERVER_PASSWORD" \
    -public $SERVER_PUBLIC

export LD_LIBRARY_PATH=$templdpath
