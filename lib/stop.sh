#!/usr/bin/env bash

ffstop() {
  # Check if docker is running
  if ! docker info >/dev/null 2>&1; then
    echo "Docker is not running, install it first or retry."
    exit 1
  fi

  # setup variables
  restname="FileFighterREST"
  frontendname="FileFighterFrontend"
  dbname="FileFighterDB"

  echo "Docker prerequisites matched. Docker instance running."
  echo "Stopping services..."

  docker stop $restname
  docker stop $frontendname
  docker stop $dbname

  echo "Finished stopping FileFighter services."
  echo "You can start them again with 'ffighter start'."
  echo ""
}
