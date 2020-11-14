#!/usr/bin/env bash
ffremove() {
  restname="FileFighterREST"
  frontendname="FileFighterFrontend"
  dbname="FileFighterDB"
  reverseproxyname="FileFighterReverseProxy"

  if [[ $(docker ps -a --format "{{.Names}}" | grep $restname) ]] || [[ $(docker ps -a --format "{{.Names}}" | grep $frontendname) ]] || [[ $(docker ps -a --format "{{.Names}}" | grep $dbname) ]] || [[ $(docker ps -a --format "{{.Names}}" | grep $reverseproxyname) ]]; then
    docker container stop $restname && docker container rm $restname
    docker container stop $frontendname && docker container rm $frontendname
    docker container stop $dbname && docker container rm $dbname
    docker container stop $reverseproxyname && docker container rm $reverseproxyname

    echo ""
    echo "Removed FileFighter Application. Install it again with 'ffighter install'."
    exit 0
  fi

  echo "FileFighter Application not found. Install it with 'ffighter install'."
  echo ""
  exit 1;
}
