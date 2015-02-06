# /**
#  * Shows the header, with or without a informative message
#  *
#  * @param {Array}  game     Contains the game data (eg: roundNumber)
#  */
function header() {
  clear
  echo "# ===================== #"
  echo "#  T I C  T A C  T O E  #"
  echo "# ===================== #"
  echo "#                       #"
  if [[ $1 == 1 ]]; then
    echo -e "# ${game[3]}"
  fi
}


# /**
#  * Shows the help
#  *
#  * @param {Array}   c       All colors availables for the output
#  */
function help() {
  echo -e "# ${c[4]}---------------------${c[0]} #"
  echo -e "# ${c[4]}To win, be the first ${c[0]} #"
  echo -e "# ${c[4]}to score 3 times     ${c[0]} #"
  echo -e "# ${c[4]}before the end of the${c[0]} #"
  echo -e "# ${c[4]}9th round.           ${c[0]} #"
  echo -e "# ${c[4]}---------------------${c[0]} #"
  echo -e "# ${c[4]}      e,q  | quit    ${c[0]} #"
  echo -e "# ${c[4]}      0-8  | play    ${c[0]} #"
  echo -e "# ${c[4]}        r  | restart ${c[0]} #"
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
  echo -e "#       ${c[6]}P O W E R${c[0]}       #"
  echo "#                       #"
}


# /**
#  * Shows the victory layout
#  *
#  * @param {Array}  c        All colors availables for the output
#  * @param {Array}  p1       Contains the player 1 informations
#  * @param {Array}  p2       Contains the player 2 informations
#  */
function victory() {
  header
  echo -e "#     ${c[2]}V I C T O R Y${c[0]}     #"
  echo -e "#                       #"
  echo -e "#         ${c[4]}${p1[2]}${c[0]} - ${c[1]}${p2[2]}${c[0]}         #"
  echo -e "#                       #"
  echo -e "#  ${c[6]}Nice play, see you!${c[0]}  #"
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
#  * @param {Array}  p1       Contains the player 1 informations
#  * @param {Array}  p2       Contains the player 2 informations
#  */
function equality() {
  header
  echo -e "#    ${c[6]}E Q U A L I T Y${c[0]}    #"
  echo -e "#                       #"
  echo -e "#      ${c[6]}Nobody won${c[0]}       #"
  echo -e "#                       #"
  echo -e "#         ${c[4]}${p1[2]}${c[0]} - ${c[1]}${p2[2]}${c[0]}         #"
  echo -e "#                       #"
  echo -e "# ${c[6]}But you can retry :)!${c[0]} #"
  footer
  exit 0
}


# /**
#  * Shows the body layout
#  *
#  * @param {Array}  c        All colors availables for the output
#  * @param {Array}  p1       Contains the player 1 informations
#  * @param {Array}  p2       Contains the player 2 informations
#  * @param {Array}  grid     Grid that contains the x and o values
#  * @param {Array}  game     Contains the game data (eg: roundNumber)
#  */
function body() {
  local p=("" "")
  if [[ ${game[1]} == 1 ]]; then
    p[0]="${c[4]}${p1[0]}${c[0]}"
    p[1]="${p2[0]}"
  else
    p[0]="${p1[0]}"
    p[1]="${c[1]}${p2[0]}${c[0]}"
  fi
  echo -e "#                       #"
  echo -e "#         ------------- #"
  echo -e "#  ${c[6]}Rnd${c[0]} ${game[0]}  | ${grid[0]} | ${grid[1]} | ${grid[2]} | #"
  echo -e "#         ------------- #"
  echo -e "#  ${p[0]}  ${p1[2]}  | ${grid[3]} | ${grid[4]} | ${grid[5]} | #"
  echo -e "#  ${p[1]}  ${p2[2]}  ------------- #"
  echo -e "#         | ${grid[6]} | ${grid[7]} | ${grid[8]} | #"
  echo -e "#         ------------- #"
  echo -e "#                       #"
}


# /**
#  * Shows the footer layout
#  */
function footer() {
  echo "# ===================== #"
  echo ""
}
