#!/bin/bash

#client.sh

input=( "$@" )


if [[ ! -p "${input[0]}.pipe" ]]; then
        mkfifo "${input[0]}.pipe"
fi


if [ "$#" -lt 2 ]; then
        echo "Error: parameters problem" >&2
	rm "${input[0]}.pipe"
        exit 1
fi

if [[ "${input[1]}" != "create" && "${input[1]}" != "add" && "${input[1]}" != "post" && "${input[1]}" != "show" && "${input[1]}" != "shutdown" ]] ; then
	echo "Error: invalid request" >&2
	rm "${input[0]}.pipe"
	exit 1
fi 





case "${input[1]}" in
        create)
		if [ "$#" -ne 3 ]; then
       			 echo "Error: parameters problem" >&2
		         rm "${input[0]}.pipe"
       			 exit 1
		fi
		
		if [ -d "${input[2]}" ]; then
  			 echo "Error: user already exists" >&2
		         rm "${input[0]}.pipe"
        		 exit 2
		fi


                echo "${input[0]}" "${input[1]}" "${input[2]}" > server.pipe
                ;;
         add)
		if [ "$#" -ne 4 ]; then
                         echo "Error: parameters problem" >&2
		         rm "${input[0]}.pipe"
                         exit 1
                fi

		if [ ! -d "${input[2]}" ]; then
       			 echo "Error: user does not exist" >&2
		         rm "${input[0]}.pipe"
       			 exit 2
		fi

		if [ ! -d "${input[3]}" ]; then
       			 echo "Error: friend does not exist" >&2
		         rm "${input[0]}.pipe"
        	         exit 2
		fi

                if grep -q "${input[3]}" "${input[2]}"/friends ; then
       			 echo "Error: user already friends with this user"
		 	 rm "${input[0]}.pipe"
       			 exit 1    
                fi

                 
                echo "${input[0]}" "${input[1]}" "${input[@]:2}" > server.pipe 
                ;;
        post)
		if [ "$#" -ne 5 ]; then
                         echo "Error: parameters problem" >&2
		         rm "${input[0]}.pipe"
                         exit 1
                fi

                if [ ! -d "${input[2]}" ]; then
       			echo "Error: receiver does not exist" >&2
			rm "${input[0]}.pipe"
        		exit 2
		fi

		if [ ! -d "${input[3]}" ]; then
        		echo "Error: sender does not exist" >&2
			rm "${input[0]}.pipe"
        		exit 2
		fi

		if ! grep -q "${input[3]}" "${input[2]}"/friends ; then
       			 echo "Error: sender is not a friend of receiver"
		         rm "${input[0]}.pipe"
       			 exit 1
		fi

                echo "${input[0]}" "${input[1]}" "${input[@]:2}" > server.pipe 
                ;;
         show)
		if [ "$#" -ne 3 ]; then
                         echo "Error: parameters problem" >&2
			 rm "${input[0]}.pipe"
                         exit 1
                fi
                 
                if [ ! -d "${input[2]}" ]; then
                         echo "Error: user does not exist" >&2
                         rm "${input[0]}.pipe"
                         exit 2
                fi


                echo "${input[0]}" "${input[1]}" "${input[2]}" > server.pipe 
                ;;
         shutdown)
                echo "${input[0]}" "${input[1]}" > server.pipe
		rm "${input[0]}.pipe"
                exit 0              
                ;;
        *)
                echo "Error: bad request"
		rm "${input[0]}.pipe"
                exit 1
esac


cat < "${input[0]}.pipe"


rm "${input[0]}.pipe"


exit 0
