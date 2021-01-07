#!/bin/bash

#add.sh

user="$1"
friend="$2"


if [ "$#" -ne 2  ]; then
        echo "Error: parameters problem" >&2
        exit 1
fi


./P.sh "$user"

if [ ! -d "$user" ]; then
        echo "Error: user does not exist" >&2
	./V.sh "$user"
        exit 2
fi


if [ ! -d "$friend" ]; then
        echo "Error: friend does not exist" >&2
	./V.sh "$user"
        exit 2
fi



if grep -q "$friend" "$user"/friends ; then
	echo "Error: user already friends with this user"
	./V.sh "$user"
	exit 1
else 

	echo "$friend" >> "$user"/friends
	echo "OK: friend added"

	./V.sh "$user"

exit 0

fi



