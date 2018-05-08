class Player
  attr_reader :name, :piece
  @@players = 0
  @@human_players = 0

  def initialize(name="Human 1", piece="X")
    @name = name
    @piece = piece
    @@players += 1
  end

  public

  def self.create_player_with_prompts
    puts "What is your name? "
    name = gets.chomp
    puts "What piece? (X or O) "
    piece = gets.chomp
    @@human_players += 1
    Player.new(name, piece)
  end
end
