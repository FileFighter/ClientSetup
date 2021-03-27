#!/usr/bin/env bash

restname="FileFighterREST"
frontendname="FileFighterFrontend"
filehandlername="FileFighterFileHandler"
networkname="FileFighterNetwork"
dbname="FileFighterDB"


ffupdate(){

echo "Starting Update."
date

if [[ $(docker ps -a --format "{{.Names}}" | grep $restname) ]] || [[ $(docker ps -a --format "{{.Names}}" | grep $frontendname) ]] || [[ $(docker ps -a --format "{{.Names}}" | grep $dbname) ]] || [[ $(docker ps -a --format "{{.Names}}" | grep $filehandlername) ]]; then
   echo "Installation is fine, starting to read config..."
else
  echo "FileFighter is not installed, run 'ffighter install' first"
fi

  source lib/config.sh     # load the config library functions
  source lib/dockertags.sh # load docker functions.

configFilePath=$(pwd)/config.cfg

  # Read in default keys.
  app_port="$(read $configFilePath app_port)"
  db_name="$(read $configFilePath db_name)"
  db_user="$(read $configFilePath db_user)"
  db_password="$(read $configFilePath db_password)"
  use_stable_versions="$(read $configFilePath use_stable_versions)"


  if ! [[ $app_port ]]; then
    echo "Config for app_port not found, using defaults."
    app_port="$(read ./lib/config.cfg.defaults app_port)"
  fi

  if ! [[ $db_name ]]; then
    echo "Config for db_name not found, using defaults."
    db_name="$(read config.cfg.defaults db_name)"
  fi

  if ! [[ $db_user ]]; then
    echo "Config for db_user not found, using defaults."
    db_user="$(read config.cfg.defaults db_user)"
  fi

  if ! [[ $db_password ]]; then
    echo "Config for db_password not found, using defaults."
    db_password="$(read config.cfg.defaults db_password)"
  fi

  # Finished Config:
  echo "Finished reading config. starting update..."

  # Check if (default) password was empty.
  if ! [[ $db_password ]]; then
    echo "Password was not set, please set the password in your config ($configFilePath) or run 'ffighter install' again"
    exit 1
  fi

  # Check versions config
  if [[ $use_stable_versions == "true" ]]; then
    echo "Updating stable versions."
   ffupdateStable
  else
    echo "Warning! Updating latest versions."
    echo "Updating latest version is not recommended and might break the application. Please report found problems here: dev@filefighter.de."
    ffupdateLatest
  fi
}

ffupdateStable(){

frontendVersionRepo="$(getTagsByName filefighter/frontend v | tail -1)"
restVersionRepo="$(getTagsByName filefighter/rest v | tail -1)"
filehandlerVersionRepo="$(getTagsByName filefighter/filehabdler v | tail -1)"

if [[ "$(docker images -q filefighter/frontend:$frontendVersionRepo 2> /dev/null)" == "" ]]; then
  echo "New version for FileFighter Frontend available, downloading it"
  docker container stop $frontendname && docker container rm $frontendname

  echo "Creating Frontend Container, with tag: $frontendVersionRepo."
  echo "Downloading filefighter/frontend image."
  docker create \
    --network $networkname \
    -p $app_port:80 \
    --name $frontendname filefighter/frontend:$frontendVersionRepo >/dev/null 2>&1

  echo "Finished downloading. Starting the updated container..."
  docker start $frontendname

else
  echo "FileFighter Frontend is up to date"
fi

if [[ "$(docker images -q filefighter/rest:$restVersionRepo 2> /dev/null)" == "" ]]; then
  echo "New version for FileFighter Rest available, downloading it"
  docker container stop $restname && docker container rm $restname

  # REST APP
  echo "Creating REST Container, with tag: $restVersionRepo."
  echo "Downloading filefighter/rest image."
  docker create \
    -e DB_USERNAME=$db_user \
    -e DB_PASSWORD=$db_password \
    -e DB_NAME=$db_name \
    -e DB_CONTAINER_NAME=$dbname \
    -e SPRING_PROFILES_ACTIVE="prod" \
    --expose 8080 \
    --network $networkname \
    --name $restname filefighter/rest:$restVersionRepo >/dev/null 2>&1

  echo "Finished downloading. Restarting the updated container..."
  docker start $restname

  echo ""
else
  echo "FileFighter FileFighter Rest is up to date"
fi

if [[ "$(docker images -q filefighter/filehandler:$filehandlerVersionRepo 2> /dev/null)" == "" ]]; then
  echo "New version for FileFighter FileHandler available, downloading it"
  docker container stop $filehandlername && docker container rm $filehandlername

  # REST APP
  echo "Creating FileHandler Container, with tag: $filehandlerVersionRepo."
  echo "Downloading filefighter/filehandler image."
  docker create \
    --network $networkname \
    --name $filehandlername filefighter/filehandler:$filehandlerVersionRepo >/dev/null 2>&1

  echo "Finished downloading. Restarting the updated container..."
  docker start $filehandlername

  echo ""
else
  echo "FileFighter FileFighter FileHandler is up to date"
fi
}

ffupdateLatest(){


echo ""

echo "Warning! Updating latest version, this is not recommended"

if ! command -v regctl &> /dev/null; then
 echo "regctl not found! Install it from here https://github.com/regclient/regclient/releases"
 echo ""
 exit 1
fi

frontendDigest="$(regctl image digest --list filefighter/frontend:latest)"
restDigest="$(regctl image digest --list filefighter/rest:latest)"
filehandlerDigest="$(regctl image digest --list filefighter/filehandler:latest)"

if [[ "$( docker inspect --format='{{.RepoDigests}}' filefighter/frontend:latest 2> /dev/null)" == "[filefighter/frontend@$frontendDigest]" ]]; then
  echo "FileFighter Frontend is up to date"
else

  echo "New version for FileFighter Frontend available, downloading it"

  docker container stop $frontendname >/dev/null 2>&1 && docker container rm $frontendname >/dev/null 2>&1
  docker rmi filefighter/frontend:latest >/dev/null 2>&1

  echo "Creating Frontend Container, with tag: latest."
  echo "Downloading filefighter/frontend image."
  docker create \
    --network $networkname \
    -p $app_port:80 \
    --name $frontendname filefighter/frontend:latest >/dev/null 2>&1

  echo "Finished downloading. Restarting the updated container..."
  docker start $frontendname >/dev/null 2>&1
fi

if [[ "$( docker inspect --format='{{.RepoDigests}}' filefighter/rest:latest 2> /dev/null)" == "[filefighter/rest@$restDigest]" ]]; then
  echo "FileFighter Rest is up to date"
else
   echo "New version for FileFighter Rest available, downloading it"

docker container stop $restname >/dev/null 2>&1 && docker container rm $restname >/dev/null 2>&1
docker rmi filefighter/rest:latest >/dev/null 2>&1

  # REST APP
  echo "Creating REST Container, with tag: latest."
  echo "Downloading filefighter/rest image."
  docker create \
    -e DB_USERNAME=$db_user \
    -e DB_PASSWORD=$db_password \
    -e DB_NAME=$db_name \
    -e DB_CONTAINER_NAME=$dbname \
    -e SPRING_PROFILES_ACTIVE="prod" \
    --expose 8080 \
    --network $networkname \
    --name $restname filefighter/rest:latest >/dev/null 2>&1

  echo "Finished downloading. Restarting the updated container..."
  docker start $restname >/dev/null 2>&1
  echo ""
fi

if [[ "$( docker inspect --format='{{.RepoDigests}}' filefighter/filehandler:latest 2> /dev/null)" == "[filefighter/filehandler@$restDigest]" ]]; then
  echo "FileFighter FileHandler is up to date"
else
   echo "New version for FileFighter FileHandler available, downloading it"

docker container stop $filehandlername >/dev/null 2>&1 && docker container rm $filehandlername >/dev/null 2>&1
docker rmi filefighter/filehandler:latest >/dev/null 2>&1

  # REST APP
  echo "Creating FileHandler Container, with tag: latest."
  echo "Downloading filefighter/filehandler image."
  docker create \
    --network $networkname \
    --name $ilehandlername filefighter/filehandler:$filehandlerVersion >/dev/null 2>&1


  echo "Finished downloading. Restarting the updated container..."
  docker start $ilehandlername >/dev/null 2>&1
  echo ""
fi
}
