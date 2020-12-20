restname="FileFighterREST"
  frontendname="FileFighterFrontend"
networkname="FileFighterNetwork"
dbname="FileFighterDB"


ffupdate(){



if [[ $(docker ps -a --format "{{.Names}}" | grep $restname) ]] || [[ $(docker ps -a --format "{{.Names}}" | grep $frontendname) ]] || [[ $(docker ps -a --format "{{.Names}}" | grep $dbname) ]] || [[ $(docker ps -a --format "{{.Names}}" | grep $reverseproxyname) ]]; then
   echo "Installation is fine, starting update"
else
  echo "FileFighter is not installed, run #ffighter install' first"
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
    echo "Password was not set, please install first."
    exit 1
  fi

  # Check versions config
  if [[ $use_stable_versions == "true" ]]; then
    echo "Updating stable versions."
   ffupdateStable
  else
    echo "Updating latest versions. Be aware that minor bugs could occur. Please report found bugs: filefigther@t-online.de."
    docker rmi filefighter/rest:latest >/dev/null 2>&1
    docker rmi filefighter/frontend:latest >/dev/null 2>&1
    docker rmi mongo >/dev/null 2>&1
  fi





}

ffupdateStable(){




    frontendVersionRepo="$(getTagsByName filefighter/frontend v | tail -1)"
    restVersionRepo="$(getTagsByName filefighter/rest v | tail -1)"

if [[ "$(docker images -q filefighter/frontend:$frontendVersionRepo 2> /dev/null)" == "" ]]; then
  echo "New version for FileFighter Frontend available, downloading it"
  docker container stop $frontendname && docker container rm $frontendname

  echo "Creating Frontend Container, with tag: $frontendVersionRepo."
  echo "Downloading filefighter/frontend image."
  docker create \
    --network $networkname \
    --name $frontendname filefighter/frontend:$frontendVersionRepo >/dev/null 2>&1
else
  echo "FileFighter Frontend is up to date"
fi
    

if [[ "$(docker images -q filefighter/rest:$restVersionRepo 2> /dev/null)" == "" ]]; then
  echo "New version for FileFighter Rest available, downloading it"
  docker container stop $frontendname && docker container rm $frontendname

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

  echo "Finished downloading."
  echo ""
else
  echo "FileFighter FileFighter Rest is up to date"
fi




}
