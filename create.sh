#!/bin/bash

#create.sh

user="$1"


if [ "$#" -ne 1  ]; then
        echo "Error: parameters problem" >&2
        exit 1
fi



./P.sh "$user"

if [ -d "$user" ]; then
        echo "Error: user already exists" >&2
	./V.sh "$user"
        exit 2
fi


mkdir "$user" 

touch "$user"/wall

touch "$user"/friends

./V.sh "$user"

echo "OK: user created"
exit 0


