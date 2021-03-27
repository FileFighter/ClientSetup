function ffstatus() {
  restname="FileFighterREST"
  frontendname="FileFighterFrontend"
  filehandlername="FileFighterFileHandler"
  dbname="FileFighterDB"

  # installed
  if [[ $(docker ps -a --format "{{.Names}}" | grep $restname) ]] || [[ $(docker ps -a --format "{{.Names}}" | grep $frontendname) ]] || [[ $(docker ps -a --format "{{.Names}}" | grep $dbname) ]] || [[ $(docker ps -a --format "{{.Names}}" | grep $filehandlername) ]]; then
    echo "FileFigher Application is currently installed."
    echo "Remove it with 'ffighter remove'."

  else
    echo "FileFigher Application is currently not installed."
    echo "Install it with 'ffighter install'."
  fi

  echo ""
  # running
  if [[ $(docker ps --format "{{.Names}}" | grep $restname) ]] || [[ $(docker ps --format "{{.Names}}" | grep $frontendname) ]] || [[ $(docker ps --format "{{.Names}}" | grep $dbname) ]] || [[ $(docker ps --format "{{.Names}}" | grep $filehandlername) ]]; then
    echo "FileFigher Application is currently running."
    echo "Stop it with 'ffighter stop'."
    echo ""
    docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"
  else
    echo "FileFigher Application is currently not running."
    echo "Run it with 'ffighter start'."
  fi
}
