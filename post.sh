#!/bin/bash

#post.sh

receiver="$1"
sender="$2"
message="$3"


if [ "$#" -ne 3  ]; then
        echo "Error: parameters problem" >&2
        exit 1
fi


./P.sh "$receiver"

if [ ! -d "$receiver" ]; then
        echo "Error: receiver does not exist" >&2
	./V.sh "$receiver"
        exit 2
fi


if [ ! -d "$sender" ]; then
        echo "Error: sender does not exist" >&2
	./V.sh "$receiver"
        exit 2
fi




if ! grep -q "$sender" "$receiver"/friends ; then
        echo "Error: sender is not a friend of receiver"
	./V.sh "$receiver"
	exit 1
else 

        echo "$sender": "$message" >> "$receiver"/wall
        echo "OK: message posted to wall"

	./V.sh "$receiver"




exit 0

fi


