#!/usr/bin/env bash

# start the application and refresh the notebook by executing all paragraphs of the notebook."
echo "start.sh started."
source bin/zeppelin.sh & sleep 12 ; \
 curl -X POST http://0.0.0.0:8080/api/notebook/import -d @'notebook/Tutorial-Booking-Table.zpln' ; \
 curl -X POST http://0.0.0.0:8080/api/notebook/job/$ZEPPELIN_NOTEBOOK_NAME

wait -n
