#!/bin/bash
# TODO: update readme.

# Read in base dir for Path.
rootDir=$(realpath $0)
rootDir=${rootDir/%Install.sh} # Very HACKY YES.
newPATH="PATH=$PATH:$rootDir"

# Add main script to PATH.
# Check files.
profile="/home/$USER/.bash_profile"
login="/home/$USER/.bash_login"
rc="/home/$USER/.bashrc"

commandToRun=""
# Checking command.
ffighter >/dev/null 2>&1

if [ $? == 127 ]; then # command does not exist add it to path
  echo "Adding FileFighter Application to PATH..."
  if [[ -f "$profile" ]]; then
    echo "$newPATH" >>"$profile"
    commandToRun="source $profile"
  elif [[ -f "$login" ]]; then
    echo "$newPATH" >>"$login"
    commandToRun="source $login"
  elif [[ -f "$rc" ]]; then
    echo "$newPATH" >>"$rc"
    commandToRun="source $rc"
  else
    echo "Couldn't add FileFighter Application to PATH. Please contact us at filefighter@t-online.de."
    echo "Or add following line to your PATH variable:"
    echo "$rootDir"
    exit 1
  fi

  echo "Adding FileFighter Application to PATH was successful."
  echo "Please run the following command to finish the installation."
  echo ""
  echo $commandToRun
else
  echo "FileFighter Application already available"
  echo "Use: ffighter <args>."
fi
