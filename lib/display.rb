require "colorize"
require_relative "cursorable"

class Display
  include Cursorable
  attr_accessor :current_color, :notifications
  attr_reader :board
  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
    @current_color = ""
    @notifications = {}
  end

  def render
    system("clear")
    build_grid.each_with_index { |row, index| puts row.join }
    notifications.each { |key, message| puts "#{message}" }
  end

  def set_check!
    notifications[:check] = "Check!"
  end

  def reset!
    notifications.delete(:error)
  end

  def remove_check!
    notifications.delete(:check)
  end

  private

  def build_grid
    @board.rows.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def same_color?
    board[@cursor_pos].color == board.current_color
  end

  def potential_move?(pos)
    board[@cursor_pos].valid_moves(@cursor_pos).include?(pos)
  end

  def build_row(row, row_idx)
    row.map.with_index do |piece, col_idx|
      color_options = colors_for(row_idx, col_idx)
      piece.to_s.colorize(color_options)
    end
  end

  def colors_for(i, j)
    if [i, j] == @cursor_pos
      bg = :light_red
    elsif potential_move?([i, j]) && same_color?
      bg = :light_yellow
    elsif (i + j).odd?
      bg = :light_black
    else
      bg = :black
    end
    { background: bg }
  end
end
