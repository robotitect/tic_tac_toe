require "./player.rb"
require "./cpu_player.rb"

class Game
  attr_accessor :board

  def initialize(players, n = 3)
    @board = Array.new(n) { Array.new(n) } # Access (row, column) : [row][column]
    @dim = n
    @squares_to_coords = {}
    x = 1
    @board.each_index do |row|
      @board[row].each_index do |col|
        @board[row][col] = x
        @squares_to_coords[x] = [row, col]
        x += 1
      end
    end
    # print_board

    @players = []
    @players.push(Player.create_player_default)
    if(players == 1)
      @players.push(CPUPlayer.create_cpu_player)
    else
      @players.push(Player.create_player_default)
    end
  end

  # Plays the game, asking each player for their move, displaying the board
  # between each move, and then checking for a win condition based on the
  # player's most recent move
  def play_game
    puts "Welcome to Tic Tac Toe (#{@dim} x #{@dim})!"
    catch :game_end do
      while(moves)
        print_board
        @players.each do |player|
          # p moves
          square_number = player.move(moves)
          set_move(player, square_number)
          # Checks if player just won with their last move
          if(won?(player, square_number))
            print_board
            display_win_message(player)
            throw :game_end
          end
        end
      end
      puts "Amazing, a tie game!"
      throw :game_end
    end

    print "Do you want to play again? [y/n] "
    answer = gets.chomp
    if(answer[0] == "y" || answer[0] == "Y")
      clear_board
      print_board
      play_game
    else
      puts "Bye!"
    end
  end

  # Tells if the player won by looking at some square id'd by number
  def won?(player, square_number)
    get_containing(square_number).any? do |array|
      array.all? do |element|
        element.to_s.strip == player.piece
      end
    end
  end

  def display_win_message(player)
    puts "#{player.name} just won."
  end

  def clear_board
    x = 1
    board_iterate do |ele, row, col|
      @board[row][col] = x
      x += 1
    end
  end

  # Calls the given player's move method, then modifies the playing board
  def set_move(player, square_number)
    board_iterate do |element, row, col|
      @board[row][col] = player.piece if element == square_number
    end
  end

  # Iterates over each element, capturing indices, takes block
  def board_iterate # (&given_proc)
    @board.each_with_index do |row, i|
      row.each_with_index do |element, j|
        # given_proc.call(element)
        yield(element, i, j)
      end
    end
  end

  # Returns array with arrays representing elements in the row, column, and
  # diagonals of the given square
  def get_containing(square)
    to_return = []
    square_row, square_col = @squares_to_coords[square]
    cont_row, cont_col, cont_diag1, cont_diag2 = [], [], [], []
    board_iterate do |ele, i, j|
      cont_row.push(ele) if i == square_row
      cont_col.push(ele) if j == square_col
      cont_diag1.push(ele) if i == j
      cont_diag2.push(ele) if i + j == @dim - 1
    end
    to_return.push(cont_row, cont_col, cont_diag1, cont_diag2)
    to_return
  end

  # Prints the current state of the playing board; looks like:
  #   1  |  2  |  3
  # -----+-----+-----
  #   4  |  5  |  6
  # -----+-----+-----
  #   7  |  8  |  9
  #
  def print_board
    puts
    @board.each_with_index do |row, index|
      print "          "
      row.each_with_index do |element, index|
        print " " + element.to_s.center(3, " ") + " "
        if(index < row.length - 1)
          print "|"
        else
          print "\n"
        end
      end

      if(index < @board.length - 1)
        print "          "
        row.each_with_index do |element, index|
          print "-----"
          if(index < row.length - 1)
            print "+"
          else
            print "\n"
          end
        end
      end
    end
    puts
  end

  # Returns all allowed moves from here on in
  def moves
    to_return = []
    board_iterate do |i|
      if(i.is_a? Numeric)
        to_return.push(i)
      end
    end
    to_return.empty? ? nil : to_return
  end

  def print_moves
    puts "Available moves: " << moves.inspect[1..-2]
  end
end
