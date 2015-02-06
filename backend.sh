# /**
#  * Initiate application's variables
#  */
function init() {
  p1=("P1" "X" "0" "4")
  p2=("P2" "O" "0" "1")
  c=('\033[0m' '\033[0;31m' '\033[0;32m' '\033[0;30m'
     '\033[0;34m' '\033[0;37m' '\033[0;33m')
  grid=("1" "2" "3" "4" "5" "6" "7" "8" "9")
  game=("1" "1" "1" "${c[4]}Enter h to show help${c[0]}  #")
}

# /**
#  * Restart the current game
#  */
function restart() {
  init
  game[3]="${c[4]}Game restarted...${c[0]}     #"
}


# /**
#  * Evaluate if there is a matching value between the two passed arguments
#  *
#  * @param  {Array}   default  A list of possibles values
#  * @param  {String}  value    The value to test
#  * @return {Integer} {1/0}    1 if true, 0 if false
#  */
function contains() {
  local n=$#
  local v=${!n}
  for ((i=1;i < $#;i++)) {
    if [ "${!i}" == "${v}" ]; then
      echo "y"
      return 0
    fi
  }
  return 1
}


# /**
#  * Quit the game after showing a banana's special layout
#  *
#  * @param {Array}  c        All colors availables for the output
#  */
function quit() {
  game[3]="       ${c[6]}banana's${c[0]}       #"
  header 1
  banana
  footer
  exit 0
}


# /**
#  * Evaluate wich action execute regarding of the user input
#  *
#  * @param {Array}  game     Contains the game data (eg: roundNumber)
#  * @param {Array}  c        All colors availables for the output
#  * @param {Array}  p1       Contains the player 1 informations
#  * @param {Array}  p2       Contains the player 2 informations
#  */
function input() {
  local p=""
  if [[ ${game[1]} == 1 ]]; then p="${p1[0]}"; else p="${p2[0]}"; fi
  read -p "  $p: " action
  if [[ $action == "q" || $action == "e" ]]; then
    main "quit"
  elif [ "$action" == "r" ]; then
    main "restart"
  elif [ "$action" == "h" ]; then
    game[3]="${c[4]}Showing help...${c[0]}       #"
    main "bob" 1
  else
    play "$action"
  fi
}


# /**
#  * Evaluate current player's pawn placements.
#  *
#  * @param {String} action   Cell where the player want's to place a pawn
#  * @param {Array}  c        All colors availables for the output
#  * @param {Array}  p1       Contains the player 1 informations
#  * @param {Array}  p2       Contains the player 2 informations
#  * @param {Array}  grid     Grid that contains the x and o values
#  * @param {Array}  game     Contains the game data (eg: roundNumber)
#  */
function play() {
  local default=("1" "2" "3" "4" "5" "6" "7" "8" "9")
  local cell=$(($action - 1))
  local name=""
  local pawn=""

  if [ $(contains "${default[@]}" "$action") == "y" ]; then

    if [ $(contains "${grid[@]}" "$action") == "y" ]; then

      if [[ ${game[1]} == 1 ]]; then
        name="${c[${p1[3]}]}${p1[0]}${c[0]}"
        pawn="${c[${p1[3]}]}${p1[1]}${c[0]}"
      else
        name="${c[${p2[3]}]}${p2[0]}${c[0]}"
        pawn="${c[${p2[3]}]}${p2[1]}${c[0]}"
      fi

      grid[$cell]="$pawn";
      game[3]="$name ${c[6]}played on cell $action${c[0]}   #"
      cortana "$pawn" "$name"
    else
      game[3]="${c[6]}Cell $action already taken!${c[0]} #"
    fi
  else
    game[3]="${c[1]}Invalid input!${c[0]}        #"
  fi
  main "bob"
}


# /**
#  * Evaluate if the current player won the round/game regardless
#  * of its last action. If nobody scoc[1] during the current round,
#  * a new one is started.
#  *
#  * @param {Array}  c        All colors availables for the output
#  * @param {Array}  p1       Contains the player 1 informations
#  * @param {Array}  p2       Contains the player 2 informations
#  * @param {Array}  grid     Grid that contains the x and o values
#  * @param {Array}  game     Contains the game data (eg: roundNumber)
#  * @param {String} name     Formated (colorized) name of current player
#  * @param {String} pawn     Formated (colorized) logo of current player
#  */
function cortana() {
  if [ $(hasWontheRound "$1") == "y" ]; then
    if [[ ${game[1]} == 1 ]]; then let p1[2]+=1; else let p2[2]+=1; fi

    if [[ ( ${p1[2]} == 3 ) || ( ${p2[2]} == 3 ) ]]; then
      main "victory"
    fi

    game[3]="$2 ${c[2]}won the round ${game[0]}!${c[0]}   #"
    main "next"
  fi

  if [[ (${game[0]} == 9 && ${game[2]} == 9) ]]; then
    main "equality"
  fi

  if {[ ${game[2]} == 9 ]]; then
    game[3]="${c[4]}Equality in round ${game[0]}${c[0]}   #"
    main "next"
  fi

  if [[ ${game[1]} == 1 ]]; then game[1]=2; else game[1]=1; fi
  main "bob"
}


# /**
#  * Return true if a player won the round
#  *
#  * @param {String} pawn     The current player´s pawn
#  * @param {Array}  grid     Grid that contains the x and o values
#  */
function hasWontheRound() {
  if [[
    (${grid[0]} == "$1" && ${grid[1]} == "$1" && ${grid[2]} == "$1") ||
    (${grid[2]} == "$1" && ${grid[5]} == "$1" && ${grid[8]} == "$1") ||
    (${grid[0]} == "$1" && ${grid[3]} == "$1" && ${grid[6]} == "$1") ||
    (${grid[6]} == "$1" && ${grid[7]} == "$1" && ${grid[8]} == "$1") ||
    (${grid[0]} == "$1" && ${grid[4]} == "$1" && ${grid[8]} == "$1") ||
    (${grid[6]} == "$1" && ${grid[4]} == "$1" && ${grid[2]} == "$1") ||
    (${grid[3]} == "$1" && ${grid[4]} == "$1" && ${grid[5]} == "$1") ||
    (${grid[1]} == "$1" && ${grid[4]} == "$1" && ${grid[7]} == "$1")
  ]]; then
    echo "y"
    return 0
  fi
  return 1
}


# /**
#  * Starts a new round or end the game by showing equality's interface
#  *
#  * @param {Array}  grid     Grid that contains the x and o values
#  * @param {Array}  game     Contains the game data (eg: roundNumber)
#  */
function next() {
  grid=("1" "2" "3" "4" "5" "6" "7" "8" "9")
  let game[0]+=1
  game[2]=1
  if [[ $((${game[0]} % 2)) == 0 ]]; then 
    let game[1]=2;
  else
    let game[1]=1;
  fi
}
