#!/usr/bin/env bash

ffstart() {
  source ./lib/config.sh # load the config library functions
  appport=$(read config.cfg app_port)

  # setup variables
  restname="FileFighterREST"
  frontendname="FileFighterFrontend"
  filehandlername="FileFighterFileHandler"
  dbname="FileFighterDB"


  if [[ $(docker ps -a --format "{{.Names}}" | grep $restname) ]] || [[ $(docker ps -a --format "{{.Names}}" | grep $frontendname) ]] || [[ $(docker ps -a --format "{{.Names}}" | grep $dbname) ]] || [[ $(docker ps -a --format "{{.Names}}" | grep $filehandlername) ]]; then
    echo "Docker prerequisites matched. Docker instance running."
    echo "Starting services..."

    docker start $dbname
    docker start $restname
    docker start $filehandlername
    docker start $frontendname


    echo ""
    echo "Finished starting FileFighter services."
    echo "Frontend is running here: http://localhost:$appport."
    echo "You can stop them again with 'ffighter stop'."
    echo ""
    exit 0
  fi

  echo "FileFighter Application not found. Install it with 'ffighter install'."
  echo ""
  exit 1;
}
