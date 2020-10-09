#!/usr/bin/env bash
source lib/config.shlib; # load the config library functions

# Check if docker is running
if ! docker info >/dev/null 2>&1; then
    echo "Docker is not running, install it or first and retry."
    exit 1
fi

# Startup Message.
echo ""
echo "------------------------< FileFighter >------------------------"
echo "->          Version 0.0.1 last updated at 09.10.20           <-"
echo "->       Developed by Gimleux, Valentin, Open-Schnick.       <-"
echo "->    Development Blog: https://www.filefighter.github.io    <-"
echo "-> The code can be found at: https://github.com/filefighter  <-"
echo "-----------------------< Initial Setup >-----------------------"
echo ""
echo "Docker prequesites matched. Docker instance running"
echo "Reading in config file at: config.cfg"

# Read in default keys.
frontend_port="$(read ./lib/config.cfg.defaults frontend_port)";
rest_port="$(read ./lib/config.cfg.defaults  rest_port)"
db_port="$(read ./lib/config.cfg.defaults  db_port)"
db_name="$(read ./lib/config.cfg.defaults db_name)"
db_user="$(read ./lib/config.cfg.defaults  db_user)"
db_password="$(read ./lib/config.cfg.defaults  db_password)"

# Overwrite default with custom config.
if [ has_key ./config.cfg $frontend_port ]; then
  # set it
  frontend_port="$(read ./config.cfg frontend_port)";
fi

if [ has_key ./config.cfg $rest_port ]; then
  # set it
  rest_port="$(read ./config.cfg rest_port)";
fi

if [ has_key ./config.cfg $db_port ]; then
  # set it
  db_port="$(read ./config.cfg db_port)";
fi

if [ has_key ./config.cfg $db_name ]; then
  # set it
  db_name="$(read ./config.cfg db_name)";
fi

if [ has_key ./config.cfg $db_user ]; then
  # set it
  db_user="$(read ./config.cfg db_user)";
fi

if [ has_key ./config.cfg $db_password ]; then
  # set it
  db_password="$(read ./config.cfg db_password)";
fi

# Check if password was empty
if [ $db_password = "" ]; then
  # Create new Password
  db_password="asdasdasd"
  write ./config.cfg db_password $db_password
fi

# Finished Config:
echo "Finished reading config file "
# CREATE CONTAINERS.

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
