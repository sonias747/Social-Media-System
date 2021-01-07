#!/bin/bash

#server.sh

if [[ ! -p server.pipe ]]; then
        mkfifo server.pipe
fi



while true; do
    read -a request < server.pipe	
    case "${request[1]}" in
	create)
            ./create.sh "${request[2]}" > "${request[0]}.pipe" & 
		;;
	add)
            ./add.sh "${request[2]}" "${request[3]}" > "${request[0]}.pipe" &
		;;
 	post)
            ./post.sh "${request[2]}" "${request[3]}" "$(echo ${request[@]:4})" > "${request[0]}.pipe" &
		;;
	show)
            ./show.sh "${request[2]}" > "${request[0]}.pipe" &
		;;
	shutdown)
       	    rm server.pipe
            exit 0
		;;
	*)
	    echo "Error: bad request"
	    rm server.pipe
	    exit 1
    esac

done


if [[ -p server.pipe ]]; then
        rm server.pipe
fi


exit 0


