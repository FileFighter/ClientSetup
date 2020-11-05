echoLogo() {
  echo "  _____   _   _          _____   _           _       _                 "
  echo " |  ___| (_) | |   ___  |  ___| (_)   __ _  | |__   | |_    ___   _ __ "
  echo " | |_    | | | |  / _ \ | |_    | |  / _\` | | '_ \  | __|  / _ \ | '__|"
  echo " |  _|   | | | | |  __/ |  _|   | | | (_| | | | | | | |_  |  __/ | |   "
  echo " |_|     |_| |_|  \___| |_|     |_|  \__, | |_| |_|  \__|  \___| |_|   "
  echo "                                     |___/                             "
  echo "                   Version $1 Last updated: $2"
  echo "              Developed by Gimleux, Valentin, Open-Schnick.            "
  echo "             Development Blog: https://filefighter.github.io           "
  echo "       The code can be found at: https://www.github.com/filefighter    "
  echo ""
  echo "-------------------------< $3 >---------------------------"
  echo ""
}

printUsage() {
  echo "usage: ffighter <args>"
  echo ""
  echo "  install   - install the FileFighter application."
  echo "  start   - start the services"
  echo "  stop   - stop the services"
  echo "  remove  - remove all services"
}