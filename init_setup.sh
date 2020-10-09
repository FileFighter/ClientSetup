#!/usr/bin/env bash
source config.shlib; # load the config library functions

# Read in config keys.
frontend_port="$(read ./config.cfg frontend_port)";
rest_port="$(read ./config.cfg  rest_port)"
db_port="$(read ./config.cfg  db_port)"
db_name="$(read ./config.cfg db_name)"
db_user="$(read ./config.cfg  db_user)"
db_password="$(read ./config.cfg  db_password)"

if [ $db_password = "" ]; then
  # set it somehow.
  db_password="asdasdasd"
  write ./config.cfg db_password $db_password
fi

# Check if docker is running
if ! docker info >/dev/null 2>&1; then
    echo "Docker is not running, install it or first and retry."
    exit 1
fi

# Docker is running try pulling images.
echo "Docker instance found."

# Database
echo "Create DB Container."
docker create -p $db_port:27017 -e MONGO_INITDB:$db_name \
-e MONGO_INITDB_ROOT_USERNAME:$db_user \
-e MONGO_INITDB_ROOT_PASSWORD:$db_password \
--name FileFighterDB mongo:latest
docker start FileFighterDB

# REST APP
echo "Create REST Container."
docker create -e DB_USERNAME=$db_user \
-e DB_PASSWORD=$db_password \
-e DB_NAME=$db_name \
-p $rest_port:8080 \
--name FileFighterREST filefighter/rest:latest
docker start FileFighterREST

# Frontend
echo "Create Frontend Container."
docker create -p $frontend_port:5000 \
-e REST_PORT=$rest_port \
--name FileFighterFrontend filefighter/frontend:latest
docker start FileFighterFrontend

# DataHandler

# TODO: Build it first.
