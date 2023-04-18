#!/bin/bash

if [ ! -f "config.lua" ]; then
	if [ -f "config.lua.sandbox" ]; then
		cp config.lua.sandbox config.lua
	fi
fi

if [ -f "config.lua" ]; then
	exec screen -dmS ot ./tfs;
fi