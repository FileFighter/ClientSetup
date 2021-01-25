#!/bin/bash

echo "Downloading FileFighter ClientSetup."
curl https://codeload.github.com/FileFighter/ClientSetup/zip/master > FileFighter.zip

echo ""
echo "finshed downloading."

if ! unzip >/dev/null 2>&1; then
  echo "'unzip' not found. Install it with 'sudo apt install unzip'."
  exit 1
fi


if [ ! -d "FileFighter" ]; then
    mkdir FileFighter
fi

unzip FileFighter.zip -d ./FileFighter

echo ""
echo "finished unpacking FileFighter. Installing it now..."
echo ""

chmod -R +x FileFighter/
$(pwd)/FileFighter/ClientSetup-master/Install.sh