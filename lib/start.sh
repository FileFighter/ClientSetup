#!/usr/bin/env bash

ffstart() {
  # Check if docker is running
  if ! docker info >/dev/null 2>&1; then
    echo "Docker is not running, install it first or retry."
    exit 1
  fi

  source ./lib/config.sh # load the config library functions
  frontendport=$(read config.cfg frontend_port)

  # setup variables
  restname="FileFighterREST"
  frontendname="FileFighterFrontend"
  dbname="FileFighterDB"

  echo "Docker prerequisites matched. Docker instance running."
  echo "Starting services..."

  docker start $restname
  docker start $frontendname
  docker start $dbname

  echo ""
  echo "Finished starting FileFighter services."
  echo "Frontend is running here: http://localhost:$frontendport."
  echo "You can stop them again with 'ffighter stop'."
  echo ""
}
