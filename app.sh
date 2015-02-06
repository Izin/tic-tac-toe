#!/bin/bash

source ./backend.sh
source ./frontend.sh


# /**
#  * Entry of the application.
#  *
#  * @author  Malo Blanchard
#  * @email   contact@maloblanchard.com
#  * @version 0.3
#  *
#  * @param {String}  $1      init, restart, or something else
#  * @param {String}  $2      1 if player wants to view help
#  */
function main() {
  case $1 in
    init)     init; main "bob";;
    next)     next;;
    quit)     quit;;
    restart)  restart;;
    victory)  victory;;
    equality) equality;;
           *)
              header 1
              body
              if [[ $2 == 1 ]]; then help; fi
              footer
              input
              ;;
  esac
}

main "init"
