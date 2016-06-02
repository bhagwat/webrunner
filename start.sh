#!/usr/bin/env bash

if [ -f env.sh ]; then
    echo "Found env.sh file. Importing bash variables"
    . ./env.sh
else
    echo "env.sh file not found. Skipping importing bash variables"
fi

LATEST_WAR_NAME=${LATEST_WAR_NAME:-latest.jar}
GRAILS_ENV=${GRAILS_ENV:-production}
PID_FILE=${PID_FILE:-run.pid}
WAR_FILE=ROOT.jar

CURRENT_TIME=$(date "+%Y.%m.%d-%H.%M.%S")
LOG_FILE_NAME=nohup.log.$CURRENT_TIME

export SERVER_PORT=${PORT:-8080}

echo "WORK DIR: $PWD"

if [ ! -f "$LATEST_WAR_NAME" ]; then
    echo "Latest war $LATEST_WAR_NAME does not exists. Exiting...."
    exit 1
fi

. ./stop.sh

echo "Removing last deployed war and using the latest one."
rm -rf $WAR_FILE
cp $LATEST_WAR_NAME $WAR_FILE

echo "Running application. PORT: $PORT, ENV: $GRAILS_ENV"
nohup java -jar $WAR_FILE > $LOG_FILE_NAME 2>&1 & echo $! > $PID_FILE
echo "Check server log:"
echo ""
echo "tail -f ${LOG_FILE_NAME}"