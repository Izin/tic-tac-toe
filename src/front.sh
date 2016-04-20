# /**
#  * Shows the header, with or without a informative message
#  */
function ttt.header() {
  clear
  echo "# ============================================== #"
  echo "#            T I C    T A C    T O E             #"
  echo "# ============================================== #"
}

#  *
#  * @param {Array}  game     Contains the game data (eg: roundNumber)
function gameData() {

  if [[ $1 == 1 ]]; then
    echo -e "# ${game[3]}"
  fi
}


# /**
#  * Shows command list
#  *
#  * @param {Array}   c       All colors availables for the output
#  */
function ttt.usage() {
  echo -e "#                                                #"
  echo -e "# ${BLU}To win, be the first ${NC}                          #"
  echo -e "# ${BLU}to score 3 times     ${NC}                          #"
  echo -e "# ${BLU}before the end of the${NC}                          #"
  echo -e "# ${BLU}9th round.           ${NC}                          #"
}

function ttt.commands() {
  echo -e "#                                                #"
  echo -e "# ${BLU}      e,q  | quit    ${NC}                          #"
  echo -e "# ${BLU}      0-8  | play    ${NC}                          #"
  echo -e "# ${BLU}        r  | restart ${NC}                          #"

}


# /**
#  * Shows a magnificient banana's power layout that illuminates your life
#  *
#  * @param {Array}   c       All colors availables for the output
#  */
function banana() {
  echo "#                   ;   #"
  echo '#   ´´.           ,#    #'
  echo '#    \ `-._____,-´=/    #'
  echo '#     `._ -^-^- _,´     #'
  echo '#        `-----´        #'
  echo "#                       #"
  echo -e "#       ${YEL}P O W E R${NC}       #"
  echo "#                       #"
}


# /**
#  * Shows the victory layout
#  *
#  * @param {Array}  c        All colors availables for the output
#  * @param {Array}  p1       Player 1
#  * @param {Array}  p2       Player 2
#  */
function victory() {
  header
  echo -e "#     ${GRE}V I C T O R Y${NC}     #"
  echo -e "#                       #"
  echo -e "#         ${BLU}${p1[2]}${NC} - ${RED}${p2[2]}${NC}         #"
  echo -e "#                       #"
  echo -e "#  ${YEL}Nice play, see you!${NC}  #"
  echo -e "#                       #"
  echo -e "#                   ;   #"
  echo -e '#   ´´.           ,#    #'
  echo -e '#    \ `-._____,-´=/    #'
  echo -e '#     `._ -^-^- _,´     #'
  echo -e '#        `-----´        #'
  echo -e "#                       #"
  footer
  exit 1
}


# /**
#  * Shows the equality layout
#  *
#  * @param {Array}  c        All colors availables for the output
#  * @param {Array}  p1       Player 1
#  * @param {Array}  p2       Player 2
#  */
function equality() {
  header
  echo -e "#    ${YEL}E Q U A L I T Y${NC}    #"
  echo -e "#                       #"
  echo -e "#      ${YEL}Nobody won${NC}       #"
  echo -e "#                       #"
  echo -e "#         ${BLU}${p1[2]}${NC} - ${RED}${p2[2]}${NC}         #"
  echo -e "#                       #"
  echo -e "# ${YEL}But you can retry :)!${NC} #"
  footer
  exit 0
}


# /**
#  * Shows the body layout
#  *
#  * @param {Array}  c        All colors availables for the output
#  * @param {Array}  p1       Player 1
#  * @param {Array}  p2       Player 2
#  * @param {Array}  cell     Grid that contains the x and o values
#  * @param {Array}  game     Contains the game data (eg: roundNumber)
#  */
function ttt.body() {
  local p1="${player1[1]} ${WHI}${player1[0]}${NC}  ${player1[2]}"
  local p2="${player2[1]} ${WHI}${player2[0]}${NC}  ${player2[2]}"

  echo -e "#    ${YEL}Round${NC}: ${round}                ┌─────┬─────┬─────┐ #"
  echo -e "#                            |  ${cell[0]}  |  ${cell[1]}  |  ${cell[2]}  | #"
  echo -e "#                            ├─────┼─────┼─────┤ #"
  echo -e "#    $p1          |  ${cell[3]}  |  ${cell[4]}  |  ${cell[5]}  | #"
  echo -e "#        vs                  ├─────┼─────┼─────┤ #"
  echo -e "#    $p2          |  ${cell[6]}  |  ${cell[7]}  |  ${cell[8]}  | #"
  echo -e "#                            └─────┴─────┴─────┘ #"
}


# /**
#  * Shows the footer layout
#  */
function ttt.footer() {
  echo "# ============================================== #"
  echo ""
}
