#!/usr/bin/env bash
ffinstall() {
  source lib/config.sh     # load the config library functions
  source lib/dockertags.sh # load docker functions.

  # setup variables
  configFilePath=$(pwd)/config.cfg
  restname="FileFighterREST"
  frontendname="FileFighterFrontend"
  filehandlername="FileFighterFileHandler"
  dbname="FileFighterDB"
  networkname="FileFighterNetwork"

  # latest stable versions.
  frontendVersion="latest"
  restVersion="latest"
  filehandlerVersion="latest"

  # cors profile
  profile="prod"

  volumesLocation="/home/$USER/filefighter/volumes"

  echo "Docker prerequisites matched. Docker instance running."
  echo "Reading in config file from: $configFilePath."

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

  if ! [[ $use_stable_versions ]]; then
    echo "Config for use_stable_versions not found, using defaults."
    use_stable_versions="$(read config.cfg.defaults use_stable_versions)"
  fi

  # Check if (default) password was empty.
  if ! [[ $db_password ]]; then
    # Create new Password
    echo "Creating new random password for the database."
    db_password=$(curl -s "https://www.passwordrandom.com/query?command=password&scheme=rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr")
    write $configFilePath db_password $db_password
  fi

  # Check versions config
  if [[ $use_stable_versions == "true" ]]; then
    echo "Installing stable versions."
    frontendVersion="$(getTagsByName filefighter/frontend v | tail -1)"
    restVersion="$(getTagsByName filefighter/rest v | tail -1)"
    filehandlerVersion="$(getTagsByName filefighter/filehandler v | tail -1)"
  else
    echo "Installing latest versions. Be aware that minor bugs could occur. Please report found bugs: filefigther@t-online.de."
    docker rmi filefighter/rest:latest >/dev/null 2>&1
    docker rmi filefighter/frontend:latest >/dev/null 2>&1
    docker rmi filefighter/filehandler:latest >/dev/null 2>&1
    docker rmi mongo >/dev/null 2>&1
  fi

  # Finished Config:
  echo "Finished reading config. Building containers..."

  # Check for already existing CONTAINERS.
  if [[ $(docker ps -a --format "{{.Names}}" | grep $restname) ]] || [[ $(docker ps -a --format "{{.Names}}" | grep $frontendname) ]] || [[ $(docker ps -a --format "{{.Names}}" | grep $dbname) ]] || [[ $(docker ps -a --format "{{.Names}}" | grep $filehandlername) ]]; then
    echo ""
    echo "A container with already exists with the name $restname or $frontendname or $dbname or $filehandlername."
    echo "Maybe its the second time that you run this script. If not please remove these containers."
    echo "If you want to check for updates, run the update.sh script."
    echo ""
    exit 1
  fi

  echo ""
  # Network
  echo "Creating necessary network."
  docker network create $networkname >/dev/null 2>&1

  # Database
  echo "Creating DB Container, with tag: latest."
  echo "Downloading mongodb image."
  docker create \
    -e MONGO_INITDB=$db_name \
    -e MONGO_INITDB_ROOT_USERNAME=$db_user \
    -e MONGO_INITDB_ROOT_PASSWORD=$db_password \
    --network $networkname \
    --name $dbname mongo:latest >/dev/null 2>&1

  echo "Finished downloading."
  echo ""

  # REST APP
  echo "Creating REST Container, with tag: $restVersion."
  echo "Downloading filefighter/rest image."
  docker create \
    -e DB_USERNAME=$db_user \
    -e DB_PASSWORD=$db_password \
    -e DB_NAME=$db_name \
    -e DB_CONTAINER_NAME=$dbname \
    -e SPRING_PROFILES_ACTIVE=$profile \
    --expose 8080 \
    --network $networkname \
    --name $restname filefighter/rest:$restVersion >/dev/null 2>&1

  echo "Finished downloading."
  echo ""

  #FileHandler
  echo "Creating FileHandler Container, with tag: $filehandlerVersion."
  echo "Downloading filefighter/filehandler image."
  docker create \
    -e PROFILE=$profile \
    -v $volumesLocation:/workdir \
    --network $networkname \
    --name $filehandlername filefighter/filehandler:$filehandlerVersion >/dev/null 2>&1

  # Frontend
  echo "Creating Frontend Container, with tag: $frontendVersion."
  echo "Downloading filefighter/frontend image."
  docker create \
    --network $networkname \
    -p $app_port:80 \
    --name $frontendname filefighter/frontend:$frontendVersion >/dev/null 2>&1

  echo "Finished downloading."
  echo ""

  echo ""
  echo "Finished Building FileFighter."
  echo "Start FileFighter with 'ffighter start'."
  echo ""
}
