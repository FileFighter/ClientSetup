#!/usr/bin/env bash

# Check if docker is running
if ! docker info >/dev/null 2>&1; then
    echo "Docker is not running, install it first or retry."
    exit 1
fi

# setup variables
restname="FileFighterREST"
frontendname="FileFighterFrontend"
dbname="FileFighterDB"

echo "  _____   _   _          _____   _           _       _                 "
echo " |  ___| (_) | |   ___  |  ___| (_)   __ _  | |__   | |_    ___   _ __ "
echo " | |_    | | | |  / _ \ | |_    | |  / _\` | | '_ \  | __|  / _ \ | '__|"
echo " |  _|   | | | | |  __/ |  _|   | | | (_| | | | | | | |_  |  __/ | |   "
echo " |_|     |_| |_|  \___| |_|     |_|  \__, | |_| |_|  \__|  \___| |_|   "
echo "                                     |___/                             "
echo "                   Version 1.2 Last updated at 29.10.20                "
echo "              Developed by Gimleux, Valentin, Open-Schnick.            "
echo "            Development Blog: https://filefighter.github.io            "
echo "       The code can be found at: https://www.github.com/filefighter    "
echo ""
echo "------------------------< Starting Services >--------------------------"
echo ""
echo "Docker prerequisites matched. Docker instance running."
echo "Stopping services..."

docker start $restname
docker start $frontendname
docker start $dbname

echo "Finished starting FileFighter services again."
echo "You can stop them again with 'sudo ./stop_services'."
echo ""
echo "------------------------< Services running >---------------------------"
echo ""