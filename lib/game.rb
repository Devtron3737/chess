require_relative "board"
require_relative "player"
require 'byebug'

class Game
  attr_reader :current_player, :board
  attr_accessor :display

  def initialize
    @board = Board.new
    @player_1 = Player.new(@board, "white")
    @player_2 = Player.new(@board, "black")
    @current_player = @player_1
    @display = Display.new(@board)
    give_color
    display.render
  end

  def play
    until game_over?
      begin
        selected_pos = @current_player.move_curser
        action_notify(selected_pos)
        set_pos = @current_player.move_curser
        board.move_piece(selected_pos, set_pos)
        swap_player!
        check_notify
      rescue StandardError => e
        error_procedure(e)
        retry
      end
    end
  end

  private

  def give_color
    board.turn_color(current_player.color)
  end

  def game_over?
    if board.checkmate?(@current_player.color)
      puts "Game over! #{@current_player.color} loses!"
      return true
    end
    false
  end

  def swap_player!
    case @current_player
    when @player_1
      @current_player = @player_2
      give_color
    else
      @current_player = @player_1
      give_color
    end
  end

  def action_notify(position)
    piece = board[position]
    display.notifications["#{piece}"] = "#{piece} selected"
    display.render
    sleep 1
    display.reset!
  end

  def check_notify
    if board.in_check?(@current_player.color)
      display.set_check!
      display.render
      sleep 2
    else
      display.remove_check!
    end
  end

  def error_procedure(error)
    display.notifications[:error] = error.message
    display.render
    sleep 2
    display.reset!
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new.play
end
