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

echoLogo v1.5 24.01.21 "Initial Install"

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