#!/bin/bash

emacsclient -n -e "(if (> (length (frame-list)) 1) 't)" | grep t > /dev/null
if [ "$?" = "1" ]; then
    emacsclient -c -n -a "" "$@"
else
    emacsclient -n -a "" "$@"
fi
