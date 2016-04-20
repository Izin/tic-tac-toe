function ttt.start() {
  init

  # Player 1
  ttt.header
  ttt.body
  ttt.usage
  ttt.commands
  ttt.footer
  player1[0]=`ttt.readPseudo "1"`

  # Player 2
  ttt.header
  ttt.body
  ttt.usage
  ttt.commands
  ttt.footer
  player2[0]=`ttt.readPseudo "2"`

  ttt.display

  return 0
}

# /**
#  * Initialize variables and constants used by the app
#  */
function init() {

  # Colors
  NC='\033[0m'     # no color
  RED='\033[0;31m'
  GRE='\033[0;32m'
  CYA='\033[0;30m'
  BLU='\033[0;34m'
  WHI='\033[0;37m'
  BLA='\033[0;30m'
  YEL='\033[0;33m'

  # Players
  PLAYER_PSEUDO_LENGTH=10
  player1=("player1   " "X" "$WHI" "0")
  player2=("player2   " "O" "$BLA" "0")

  # Grid
  cell=("1" "2" "3" "4" "5" "6" "7" "8" "9")

  # Game
  round=1
  movements=0 # strokes made by all players
  INFO="${CYA}Enter h to show help${NC}"

  return 0
}


function ttt.display() {
  ttt.header
  ttt.body
  ttt.footer
  input

  return 0
}


##
#
#
# @return {String} Fixed length string containing a formated pseudo
#
function ttt.readPseudo() {

  while true
  do
    read -p "  Enter a pseudo for player $1: " pseudo
    pseudo=`ttt.trim "$pseudo"`

    if [ -n "$pseudo" ]
    then
      pseudo=`ttt.replace "$pseudo" ' ' '-'`
      local size=`ttt.length "$pseudo"`

      if [ $size -gt $PLAYER_PSEUDO_LENGTH ]
      then
        pseudo=${pseudo:0:$PLAYER_PSEUDO_LENGTH}

      else
        for ((i = 0; i < (($PLAYER_PSEUDO_LENGTH - $size)); i++)); do
          pseudo="$pseudo "
        done
      fi

      echo "$pseudo"
      break
    fi
  done
  return 0
}



# /**
#  * Restart the current game
#  */
function restart() {
  init
  INFO="${CYA}Game restarted...${NC}"
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
  INFO="       ${YEL}banana's${NC}"
  ttt.header 1
  banana
  ttt.footer
  exit 0
}


# /**
#  * Evaluate wich action execute regarding of the user input
#  *
#  * @param {Array}  game     Contains the game data (eg: roundNumber)
#  * @param {Array}  c        All colors availables for the output
#  * @param {Array}  player1       Contains the player 1 informations
#  * @param {Array}  player2       Contains the player 2 informations
#  */
function input() {
  local p=""
  if [[ ${game[1]} == 1 ]]; then p="${player1[0]}"; else p="${player2[0]}"; fi
  read -p "  $p: " action
  if [[ $action == "q" || $action == "e" ]]; then
    main "quit"
  elif [ "$action" == "r" ]; then
    main "restart"
  elif [ "$action" == "h" ]; then
    INFO="${CYA}Showing help...${NC}"
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
#  * @param {Array}  player1       Contains the player 1 informations
#  * @param {Array}  player2       Contains the player 2 informations
#  * @param {Array}  cell     Grid that contains the x and o values
#  * @param {Array}  game     Contains the game data (eg: roundNumber)
#  */
function play() {
  local default=("1" "2" "3" "4" "5" "6" "7" "8" "9")
  local cell=$(($action - 1))
  local name=""
  local pawn=""

  if [ $(contains "${default[@]}" "$action") == "y" ]; then

    if [ $(contains "${cell[@]}" "$action") == "y" ]; then

      if [[ ${game[1]} == 1 ]]; then
        name="${c[${player1[3]}]}${player1[0]}${NC}"
        pawn="${c[${player1[3]}]}${player1[1]}${NC}"
      else
        name="${c[${player2[3]}]}${player2[0]}${NC}"
        pawn="${c[${player2[3]}]}${player2[1]}${NC}"
      fi

      cell[$cell]="$pawn";
      INFO="$name ${YEL}played on cell $action${NC}"
      cortana "$pawn" "$name"
    else
      INFO="${YEL}Cell $action already taken!${NC}"
    fi
  else
    INFO="${RED}Invalid input!${NC}"
  fi
  main "bob"
}


# /**
#  * Evaluate if the current player won the round/game regardless
#  * of its last action. If nottt.body scoc[1] during the current round,
#  * a new one is started.
#  *
#  * @param {Array}  c        All colors availables for the output
#  * @param {Array}  player1       Contains the player 1 informations
#  * @param {Array}  player2       Contains the player 2 informations
#  * @param {Array}  cell     Grid that contains the x and o values
#  * @param {Array}  game     Contains the game data (eg: roundNumber)
#  * @param {String} name     Formated (colorized) name of current player
#  * @param {String} pawn     Formated (colorized) logo of current player
#  */
function cortana() {
  if [ $(hasWontheRound "$1") == "y" ]; then
    if [[ ${game[1]} == 1 ]]; then let player1[2]+=1; else let player2[2]+=1; fi

    if [[ ( ${player1[2]} == 3 ) || ( ${player2[2]} == 3 ) ]]; then
      main "victory"
    fi

    INFO="$2 ${c[2]}won the round ${game[0]}!${NC}"
    main "next"
  fi

  if [[ (${game[0]} == 9 && ${game[2]} == 9) ]]; then
    main "equality"
  fi

  if {[ ${game[2]} == 9 ]]; then
    INFO="${CYA}Equality in round ${game[0]}${NC}"
    main "next"
  fi

  if [[ ${game[1]} == 1 ]]; then game[1]=2; else game[1]=1; fi
  main "bob"
}


# /**
#  * Return true if a player won the round
#  *
#  * @param {String} pawn     The current player´s pawn
#  * @param {Array}  cell     Grid that contains the x and o values
#  */
function hasWontheRound() {
  if [[
    (${cell[0]} == "$1" && ${cell[1]} == "$1" && ${cell[2]} == "$1") ||
    (${cell[2]} == "$1" && ${cell[5]} == "$1" && ${cell[8]} == "$1") ||
    (${cell[0]} == "$1" && ${cell[3]} == "$1" && ${cell[6]} == "$1") ||
    (${cell[6]} == "$1" && ${cell[7]} == "$1" && ${cell[8]} == "$1") ||
    (${cell[0]} == "$1" && ${cell[4]} == "$1" && ${cell[8]} == "$1") ||
    (${cell[6]} == "$1" && ${cell[4]} == "$1" && ${cell[2]} == "$1") ||
    (${cell[3]} == "$1" && ${cell[4]} == "$1" && ${cell[5]} == "$1") ||
    (${cell[1]} == "$1" && ${cell[4]} == "$1" && ${cell[7]} == "$1")
  ]]; then
    echo "y"
    return 0
  fi
  return 1
}


# /**
#  * Starts a new round or end the game by showing equality's interface
#  *
#  * @param {Array}  cell     Grid that contains the x and o values
#  * @param {Array}  game     Contains the game data (eg: roundNumber)
#  */
function next() {
  cell=("1" "2" "3" "4" "5" "6" "7" "8" "9")
  let game[0]+=1
  game[2]=1
  if [[ $((${game[0]} % 2)) == 0 ]]; then
    let game[1]=2;
  else
    let game[1]=1;
  fi
}
