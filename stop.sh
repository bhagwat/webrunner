#!/usr/bin/env bash
ARG_1=$1
PID_FILE=${ARG_1:-run.pid}

if [ -f "$PID_FILE" ]; then
    echo "PID File exists with PID `cat run.pid`."
    if [[ $(ps -o pid= -p `cat run.pid` | wc -c) -ne 0 ]]; then
        echo "Trying to kill the process...";
        kill -9 `cat run.pid`
        sleep 3
    else
        echo "PID file exists but process is not running. Skipping..."
    fi
    rm -rf $PID_FILE
fi
