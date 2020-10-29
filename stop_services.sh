#!/usr/bin/env bash

# Check if docker is running
if ! docker info >/dev/null 2>&1; then
    echo "Docker is not running, install it or first and retry."
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
echo "------------------------< Stopping Services >--------------------------"
echo ""
echo "Docker prerequisites matched. Docker instance running."
echo "Stopping services..."

docker stop $restname
docker stop $frontendname
docker stop $dbname

echo "Finished stopping FileFighter services."
echo "You can start them again with 'sudo ./start_services'."
echo ""
echo "------------------------< Services stopped >---------------------------"
echo ""