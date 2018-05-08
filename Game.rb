require "./Player.rb"
require "./CPUPlayer.rb"

class Game
  def initialize(players) # (n)
    @board = Array.new(3) { Array.new(3) } # Access (row, column) : [row][column]
    x = 1
    @board.each_index do |row|
      @board[row].each_index do |col|
        @board[row][col] = x
        x += 1
      end
    end

    @players = []
    @players.push(Player.new())
    # @players[Player.new] = "X"
    if(players == 1)
      @players.push(CPUPlayer.new())
    else
      @players.push(Player.new())
    end
    # @players[1] = "O"
    # human_players.do { @players.push(Player.new) }
    # cpu_players.do { @players.push(CPUPlayer.new) }
  end

  # Plays the game, asking each player for their move, displaying the board
  # between each move, and then checking for a win condition based on the
  # player's most recent move
  def play_game
    loop do
      players.each do |player|
        # ask for a player's move,
      end
    end
  end


  def set_move(player, square_number)
    set = proc { |element| element = player.piece if element == square_number }
    board_iterate(&set)
  end

  # iterates
  def board_iterate(&given_proc)
    @board.each_with_index do |row, index|
      row.each_with_index do |element, index|
        given_proc.call(element)
      end
    end
  end

  # Prints the current state of the playing board
  def print_board
    puts
    @board.each_with_index do |row, index|
      print "               "
      row.each_with_index do |element, index|
        print " " + element.to_s + " "
        if(index < row.length - 1)
          print "|"
        else
          print "\n"
        end
      end

      if(index < @board.length - 1)
        print "               "
        row.each_with_index do |element, index|
          print "---"
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
    @board.each do |row|
      row.each do |i|
        if(i.is_a? Numeric)
          to_return.push(i)
        end
      end
    end
    to_return.inspect[1..-2]
  end
end

game = Game.new(1)
game.print_board
puts game.moves
