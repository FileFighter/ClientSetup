#!/usr/bin/env bash

ffstop() {  # setup variables
  restname="FileFighterREST"
  frontendname="FileFighterFrontend"
  dbname="FileFighterDB"
  reverseproxyname="FileFighterReverseProxy"

  echo "Docker prerequisites matched. Docker instance running."
  echo "Stopping services..."

  docker stop $restname
  docker stop $frontendname
  docker stop $dbname
  docker stop $reverseproxyname

  echo "Finished stopping FileFighter services."
  echo "You can start them again with 'ffighter start'."
  echo ""
}
