#!/bin/bash

DOWNLOAD_DIR="/tmp"

cd $DOWNLOAD_DIR
echo "Downloading FileFighter ClientSetup."
curl https://codeload.github.com/FileFighter/ClientSetup/zip/master > FileFighter.zip

echo ""
echo "finshed downloading."

if ! unzip>/dev/null 2>&1; then
  echo "'unzip' not found. Install it with 'sudo apt install unzip'."
  exit 1
fi

unzip -o FileFighter.zip >/dev/null 2>&1

echo ""
echo "finished unpacking FileFighter. Installing it now..."
echo ""

chmod -R +x $DOWNLOAD_DIR/ClientSetup-master/
cd $DOWNLOAD_DIR/ClientSetup-master/
./Install.sh
