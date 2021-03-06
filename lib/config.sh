sed_escape() {
  sed -e 's/[]\/$*.^[]/\\&/g'
}

write() { # path, key, value
  delete "$1" "$2"
  echo "$2=$3" >> "$1"
}

read() { # path, key -> value
  test -f "$1" && grep "^$(echo "$2" | sed_escape)=" "$1" | sed "s/^$(echo "$2" | sed_escape)=//" | tail -1
}

delete() { # path, key
  test -f "$1" && sed -i "/^$(echo $2 | sed_escape).*$/d" "$1"
  # MacOs
  # test -f "$1" && sed -i "" -e "/^$(echo $2 | sed_escape).*$/d" "$1"
}

has_key() { # path, key
  test -f "$1" && grep "^$(echo "$2" | sed_escape)=" "$1" > /dev/null
}
