#!/usr/bin/env bash

ffstart() {
  source ./lib/config.sh # load the config library functions
  frontendport=$(read config.cfg frontend_port)

  # setup variables
  restname="FileFighterREST"
  frontendname="FileFighterFrontend"
  dbname="FileFighterDB"
  reverseproxyname="FileFighterReverseProxy"

  if [[ $(docker ps -a --format "{{.Names}}" | grep $restname) ]] || [[ $(docker ps -a --format "{{.Names}}" | grep $frontendname) ]] || [[ $(docker ps -a --format "{{.Names}}" | grep $dbname) ]] || [[ $(docker ps -a --format "{{.Names}}" | grep $reverseproxyname) ]]; then
    echo "Docker prerequisites matched. Docker instance running."
    echo "Starting services..."

    docker start $restname
    docker start $frontendname
    docker start $dbname
    docker start $reverseproxyname

    echo ""
    echo "Finished starting FileFighter services."
    echo "Frontend is running here: http://localhost:$frontendport."
    echo "You can stop them again with 'ffighter stop'."
    echo ""
    exit 0
  fi

  echo "FileFighter Application not found. Install it with 'ffighter install'."
  echo ""
  exit 1;
}
