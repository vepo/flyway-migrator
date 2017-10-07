#!/bin/bash

server_info() {
    OUTPUT=$(./flyway -X -user=$DB_USER -password=$DB_PASSWORD -url=jdbc:$DB_URL info 2> err.txt)
    RESULT=$?
}

is_server_listening() {
    if [ "$RESULT" == "0" ]; then
        return 1
    else 
        return 0
    fi
}

server_info

while [[ $(is_server_listening; echo $?) -eq 0 ]]; do
    echo "Waiting for database server..."
    sleep 5s
    server_info
done

OUTPUT=$(./flyway -X -user=$DB_USER -password=$DB_PASSWORD -url=jdbc:$DB_URL migrate)
RESULT=$?

echo "RESULT: $RESULT $OUTPUT"