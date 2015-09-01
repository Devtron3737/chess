require_relative "board"
require_relative "player"

class Game
  attr_accessor :board
  def initialize
    @board = Board.new
    @player_1 = Player.new(@board, "white")
    @player_2 = Player.new(@board, "black")
  end

  def play
    current_player = @player_1
    selected_pos = current_player.move_curser # gets input from move_curser method
    set_pos = current_player.move_curser # gets input form move_curser method
    board.move_piece(selected_pos, set_pos) # tells board to validate and move piece
    board.render
    swap_player
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new.play
end
