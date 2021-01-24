#!/bin/bash

# Source logo and usage.
source ./lib/utils.sh

# Move other files in this dir to /home/$USER/filefighter/
SCRIPTS_LOCATION="/home/$USER/filefighter"

# Move ffighter to this dir.
APPLICATION_LOCATION="/usr/bin"

# Read in base dir for Path.
DOWNLOAD_LOCATION=$(realpath $0)
DOWNLOAD_LOCATION=${DOWNLOAD_LOCATION/%Install.sh} # Very HACKY YES.

VERSION="v1.6"
DATE="24.01.21"

echoLogo $VERSION $DATE "Initial Install"

if [ ! -d "/home/$USER" ]; then
  echo "Home directory for the current user not found. If you are root, switch to a user with a directory under /home/"
  exit 1
fi

if [ ! -d $SCRIPTS_LOCATION ]; then
  echo "Creating Install Location under $SCRIPTS_LOCATION"
  mkdir $SCRIPTS_LOCATION
fi

echo "Copying Scripts to new location..."
cd $DOWNLOAD_LOCATION
cp -r . $SCRIPTS_LOCATION

echo "Copying FileFighter Application to $APPLICATION_LOCATION..."
echo "This may need administrator rights (sudo) if you are not root."
sudo cp $DOWNLOAD_LOCATION/ffighter $APPLICATION_LOCATION

echo ""
echo "Successfully installed FileFighter!"
printUsage