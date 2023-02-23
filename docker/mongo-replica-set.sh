#!/bin/bash

replSetName='rs0'
databaseName='db'

docker run -d --rm --name mongo1 --net host mongo mongod --port 27017 --replSet $replSetName
docker run -d --rm --name mongo2 --net host mongo mongod --port 27018 --replSet $replSetName
docker run -d --rm --name mongo3 --net host mongo mongod --port 27019 --replSet $replSetName
sleep 15
docker exec mongo1 mongosh --eval "use $databaseName" --eval "rs.initiate({ \"_id\": \"$replSetName\", \"members\": [{ \"_id\": 0, \"host\": \"localhost:27017\" }, { \"_id\": 1, \"host\": \"localhost:27018\" }, { \"_id\": 2, \"host\": \"localhost:27019\" }] })"
                                                                     