Tic Tac Toe Classes:
====================
## Game (TicTacToe)
### Variables
* board : 3x3 hash representing game state (maybe extend to NxN, initial param)
 * hash: squares_by_number => number OR player piece
* players : based on 1 (adds a computer player) or 2 (humans)
 * hash: player_name => playing piece ("X" or "O")

### Methods
* play_game : endless loop, decide how to implement later
* moves : returns a list of possible moves
* display_board : shows the board, print statements galore
* set_move(player_name, square) : calls player_name.move FIRST, then passes into this
* check_win(player) : checks if a player has won
* display_win_message(player) : tells if a player has won
* start_over(boolean same_players?) : restart the game

## Player
### Variables
* name : ? maybe not

### Methods
* move(game) : prints possible moves with game.moves (maybe not), prompts user for a number corresponding to square they want to place move, returns that move to the caller

## CPUPlayer < Player
### Methods
* move(game) : override, returns a random move instead of prompting user
