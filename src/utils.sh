
function ttt.replace() {
  echo "$1" | sed "s/$2/$3/g"
  return 0
}

function ttt.trim() {
  echo "$1" | sed 's/^ *//;s/ *$//;s/ *//;'
  return 0
}

function ttt.length() {
  echo "${#1}"
  return 0
}
