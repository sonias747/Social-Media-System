#!/bin/bash

#show.sh

user="$1"

if [ "$#" -ne 1  ]; then
        echo "Error: parameters problem" >&2
        exit 1
fi

./P.sh "$user"

if [ ! -d "$user" ]; then
        echo "Error: user does not exist" >&2
	./V.sh "$user"
        exit 2
fi




echo "wallStart"

cat "$user"/wall

echo "wallEnd"


./V.sh "$user"


exit 0

