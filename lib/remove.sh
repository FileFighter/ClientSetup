#!/usr/bin/env bash
ffremove() {
  restname="FileFighterREST"
  frontendname="FileFighterFrontend"
  filehandlername="FileFighterFileHandler"
  dbname="FileFighterDB"

  if [[ $(docker ps -a --format "{{.Names}}" | grep $restname) ]] || [[ $(docker ps -a --format "{{.Names}}" | grep $frontendname) ]] || [[ $(docker ps -a --format "{{.Names}}" | grep $dbname) ]] || [[ $(docker ps -a --format "{{.Names}}" | grep $filehandlername) ]]; then
    docker container stop $restname && docker container rm $restname >/dev/null 2>&1
    docker container stop $frontendname && docker container rm $frontendname >/dev/null 2>&1
    docker container stop $dbname && docker container rm $dbname >/dev/null 2>&1
    docker container stop $filehandlername && docker container rm $filehandlername >/dev/null 2>&1

    echo ""
    echo "Removed FileFighter Application. Install it again with 'ffighter install'."
    exit 0
  fi

  echo "FileFighter Application not found. Install it with 'ffighter install'."
  echo ""
  exit 1;
}
