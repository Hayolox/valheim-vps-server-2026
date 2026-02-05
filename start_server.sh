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
