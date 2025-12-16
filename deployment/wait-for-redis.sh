#!/usr/bin/env bash

CACHE_URL="redis://127.0.0.1:13001"
QUEUE_URL="redis://127.0.0.1:11001"

MAX_ATTEMPTS=120
attempts=0

until [ $attempts -ge $MAX_ATTEMPTS ]
do
    if ( redis-cli -u $QUEUE_URL PING | grep -q PONG ) && ( redis-cli -u $CACHE_URL PING | grep -q PONG ); then
        break
    fi
    sleep 1
    echo "Waiting for Redis to be ready..."
    ((attempts=attempts+1))
done