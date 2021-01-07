#!/bin/bash

#V.sh

if [ -z "$1" ]; then
	echo "Usage: $0 mutex-name"
	exit 1
else
	rm "$1-lock"
	exit 0
fi
