#!/usr/bin/env bash
source lib/config.shlib; # load the config library functions

# Check if docker is running
if ! docker info >/dev/null 2>&1; then
    echo "Docker is not running, install it or first and retry."
    exit 1
fi

configFilePath=$(pwd)/config.cfg
# Startup Message.
echo ""
echo "-------------------------< FileFighter >--------------------------"
echo "->           Version 0.0.1 last updated at 09.10.20             <-"
echo "->        Developed by Gimleux, Valentin, Open-Schnick.         <-"
echo "->       Development Blog: https://filefighter.github.io        <-"
echo "-> The code can be found at: https://www.github.com/filefighter <-"
echo "--------------------< Started Initial Setup >---------------------"
echo ""
echo "Docker prequesites matched. Docker instance running."
echo "Reading in config file from: $configFilePath."

# Read in default keys.
frontend_port="$(read ./config.cfg frontend_port)";
rest_port="$(read ./config.cfg  rest_port)"
db_port="$(read ./config.cfg  db_port)"
db_name="$(read ./config.cfg db_name)"
db_user="$(read ./config.cfg  db_user)"
db_password="$(read ./config.cfg  db_password)"

if ! [[ $frontend_port ]]; then
    echo "Config for frontend_port not found, using defaults."
    frontend_port="$(read ./config.cfg frontend_port)"
fi

if ! [[ $rest_port ]]; then
    echo "Config for rest_port not found, using defaults."
    rest_port="$(read ./config.cfg rest_port)"
fi

if ! [[ $db_port ]]; then
    echo "Config for db_port not found, using defaults."
    db_port="$(read ./config.cfg db_port)"
fi

if ! [[ $db_name ]]; then
    echo "Config for db_name not found, using defaults."
    db_name="$(read ./config.cfg db_name)"
fi

if ! [[ $db_user ]]; then
    echo "Config for db_user not found, using defaults."
    db_user="$(read ./config.cfg db_user)"
fi

if ! [[ $db_password ]]; then
    echo "Config for db_password not found, using defaults."
    db_password="$(read ./config.cfg db_password)"
fi

# Check if (default) password was empty.
if ! [[ $db_password ]]; then
  # Create new Password
  echo "Creating new random password for the database."
  db_password="asdasdasd"
  write $configFilePath db_password $db_password
fi

# Finished Config:
echo "Finished reading config. Building containers..."

# Check for already running CONTAINERS.
if [[ $(docker ps --format "{{.Names}}" | grep FileFighterREST) ]] || [[ $(docker ps --format "{{.Names}}" | grep FileFighterFrontend) ]] || [[ $(docker ps --format "{{.Names}}" | grep FileFighterDB) ]]; then
echo ""
echo "A container with already exists with the name FileFighterREST or FileFighterFrontend or FileFighterDB."
echo "Maybe its the second time that you run this script. If not please remove these containers."
echo "If you want to check for updated run the update.sh script."
echo ""
  exit 1;
fi
#docker stop FileFighterREST
#docker rm FileFighterREST
#docker stop FileFighterFrontend
#docker rm FileFighterFrontend

# CREATE CONTAINERS.

# Database
echo "Creating DB Container."
docker create -p $db_port:27017 -e MONGO_INITDB=$db_name \
-e MONGO_INITDB_ROOT_USERNAME=$db_user \
-e MONGO_INITDB_ROOT_PASSWORD=$db_password \
--name FileFighterDB mongo:latest >/dev/null 2>&1
docker start FileFighterDB >/dev/null 2>&1

# REST APP
echo "Creating REST Container."
docker create -e DB_USERNAME=$db_user \
-e DB_PASSWORD=$db_password \
-e DB_NAME=$db_name \
-p $rest_port:8080 \
--name FileFighterREST filefighter/rest:latest >/dev/null 2>&1
docker start FileFighterREST >/dev/null 2>&1

# Frontend
echo "Creating Frontend Container."
docker create -p $frontend_port:5000 \
-e REST_PORT=$rest_port \
--name FileFighterFrontend filefighter/frontend:0.0.1 >/dev/null 2>&1
docker start FileFighterFrontend >/dev/null 2>&1

# DataHandler


echo ""
echo "Hosting Frontend at: http://localhost:$frontend_port/"
echo "--------------------< Finished Initial Setup >--------------------"
echo ""
