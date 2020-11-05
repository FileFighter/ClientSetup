#!/usr/bin/env bash
ffremove() {
  restname="FileFighterREST"
  frontendname="FileFighterFrontend"
  dbname="FileFighterDB"

  docker container stop $restname && docker container rm $restname
  docker container stop $frontendname && docker container rm $frontendname
  docker container stop $dbname && docker container rm $dbname
}
