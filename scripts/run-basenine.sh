#!/bin/bash

set -ex

PROCESS_NAME="basenine"

if pidof "$PROCESS_NAME" >/dev/null; then
    echo "$PROCESS_NAME already running"
    exit 0
else
    nohup basenine --debug >2 >&1 &

    # basenine --debug

fi
