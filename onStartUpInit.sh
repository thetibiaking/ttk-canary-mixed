#!/bin/bash

cd /home/server1305;

if [ ! -f "config.lua" ]; then
	if [ -f "config.lua.production" ]; then
		cp config.lua.production config.lua
	fi
fi

if [ -f "config.lua" ]; then
	exec screen -dmS test ./start.sh;
fi