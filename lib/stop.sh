#!/usr/bin/env bash

ffstop() {  # setup variables
  restname="FileFighterREST"
  frontendname="FileFighterFrontend"
  filehandlername="FileFighterFileHandler"
  dbname="FileFighterDB"

  echo "Docker prerequisites matched. Docker instance running."
  echo "Stopping services..."

  docker stop $frontendname
  docker stop $restname
  docker stop $filehandlername
  docker stop $dbname

  echo "Finished stopping FileFighter services."
  echo "You can start them again with 'ffighter start'."
  echo ""
}
