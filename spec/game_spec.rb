load "game.rb"

describe Game do
  let(:game_ai) { Game.new(1, 3) }
  context "won?" do
    example_group "boards with a win" do
      example "X X X along top" do
        game_ai.board = [["X", "X", "X"],
                         ["4", "5", "6"],
                         ["7", "8", "9"]]
        expect(game_ai.won?(game_ai.players.first, 3)).to eql(true)
      end

      example "O O O along right side" do
        game_ai.board = [[1, 2, "O"],
                         [4, 5, "O"],
                         [7, 8, "O"]]
        expect(game_ai.won?(game_ai.players[1], 6)).to eql(true)
      end

      example "diagonal top left -> bottom right" do
        game_ai.board = [["X", "2", "3"],
                         ["4", "X", "6"],
                         ["7", "8", "X"]]
        expect(game_ai.won?(game_ai.players.first, 5)).to eql(true)
      end

      example "diag top right -> bottom left" do
        game_ai.board = [["1", "2", "X"],
                         ["4", "X", "6"],
                         ["X", "8", "9"]]
        expect(game_ai.won?(game_ai.players.first, 5)).to eql(true)
      end
    end

    example_group "boards without a win" do
      example "X O X along top" do
        game_ai.board = [["X", "O", "X"],
                         ["4", "5", "6"],
                         ["7", "8", "9"]]
        expect(game_ai.won?(game_ai.players.first, 3)).to eql(false )
      end
    end
  end

  context "get_containing" do
    example "X in the middle" do
      game_ai.board = [["1", "2", "X"],
                       ["4", "X", "6"],
                       ["X", "8", "9"]]
      expect(game_ai.get_containing(5)).to eql([["4", "X", "6"],
                                                ["2", "X", "8"],
                                                ["1", "X", "9"],
                                                ["X", "X", "X"]])
    end
  end

  context "moves" do
    it "returns all the valid moves for an empty board" do
      game_ai.board = [[1, 2, 3],
                       [4, 5, 6],
                       [7, 8, 9]]
      expect(game_ai.moves).to eql([*(1..9)])
    end

    it "returns all the valid moves mid-game" do
      game_ai.board = [[1, 2, "O"],
                       [4, 5, "O"],
                       [7, 8, "O"]]
      expect(game_ai.moves).to eql([1, 2, 4, 5, 7, 8])
    end
  end

  context "set_move" do
    it "sets move on empty board" do
      game_ai.board = [[1, 2, 3],
                       [4, 5, 6],
                       [7, 8, 9]]
      game_ai.set_move(game_ai.players.first, 3)
      expect(game_ai.moves).to eql([1, 2, 4, 5, 6, 7, 8, 9])
      expect(game_ai.board).to eql([[1, 2, "X"],
                                    [4, 5, 6],
                                    [7, 8, 9]])
    end

    it "doesn't set a move on a filled square" do
      game_ai.board = [[1, 2, "X"],
                       [4, 5, 6],
                       [7, 8, 9]]
      game_ai.set_move(game_ai.players.last, 3)
      expect(game_ai.board).to eql([[1, 2, "X"],
                                    [4, 5, 6],
                                    [7, 8, 9]])
    end
  end

  context "clear_board" do
    it "clears an in-progress game" do
      game_ai.board = [[1, 2, "X"],
                       [4, 5, 6],
                       [7, 8, 9]]
      game_ai.clear_board
      expect(game_ai.board).to eql([[*(1..3)], [*(4..6)], [*(7..9)]])
    end
  end

  context "CPUPlayer#move" do
    let(:cpu) { game_ai.players.last }

    it "chooses a valid move" do
      game_ai.board = [[1, 2, "X"],
                       [4, 5,  6 ],
                       [7, 8,  9 ]]
      expect(game_ai.moves).to include(cpu.move(game_ai.moves))
    end
  end
end
