set -e

echoLogo() {
  echo "  _____   _   _          _____   _           _       _                 "
  echo " |  ___| (_) | |   ___  |  ___| (_)   __ _  | |__   | |_    ___   _ __ "
  echo " | |_    | | | |  / _ \ | |_    | |  / _\` | | '_ \  | __|  / _ \ | '__|"
  echo " |  _|   | | | | |  __/ |  _|   | | | (_| | | | | | | |_  |  __/ | |   "
  echo " |_|     |_| |_|  \___| |_|     |_|  \__, | |_| |_|  \__|  \___| |_|   "
  echo "                                     |___/                             "
  echo "              Developed by Gimleux, Valentin, Open-Schnick.            "
  echo "             Development Blog: https://blog.filefighter.de           "
  echo "       The code can be found at: https://www.github.com/filefighter    "
  echo ""
  echo "-------------------------< DB SETUP >---------------------------"
  echo ""
}

echoLogo

echo "Adding users with init script"

echo "Adding user $FH_DB_USERNAME to db $FH_DB_NAME"

mongo <<EOF

print("Started Adding the Users.");
db = db.getSiblingDB('$FH_DB_NAME');
print("Adding FH user to db:" , db);
db.createUser({
  user: '$FH_DB_USERNAME',
  pwd: '$FH_DB_PASSWORD',
  roles: [{ role: "readWrite", db: '$FH_DB_NAME' }],
});
print("End Adding the Users.");

EOF
