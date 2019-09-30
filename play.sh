#!/bin/bash

# Name:         TicTacToe
# Description:  A simple ASCII Tic Tac Toe game made
# Author:       Malo Blanchard
# version:      2.0.0

set -eu

#@todo replace ttt. by ttt- (prefix for functions)
#@todo very function with a space before ()
# @todo functions comments with single '#'

source ./src/utils.sh
source ./src/back.sh
source ./src/front.sh

# Go!
ttt.start
