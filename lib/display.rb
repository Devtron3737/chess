require "colorize"
require_relative "cursorable"

class Display
  include Cursorable

  attr_reader :board
  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
  end

  def build_grid
    @board.rows.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, row_idx)
    row.map.with_index do |piece, col_idx|
      color_options = colors_for(row_idx, col_idx)
      piece.to_s.colorize(color_options)
    end
  end

  #every cursor move re-renders the board with updated square colors
  #want to select possible moves of piece at @cursor_pos
  #and set background color for all of those to :light_yellow
  def colors_for(i, j)
    if [i, j] == @cursor_pos
      bg = :light_red
      # if
    elsif board[@cursor_pos].moves(@cursor_pos).include?([i, j])
      bg = :light_yellow
    elsif (i + j).odd?
      bg = :light_blue
    else
      bg = :blue
    end
    { background: bg }
    # { background: bg, color: :white }
  end

  def render
    system("clear")
    build_grid.each_with_index { |row, index| puts row.join }
  end
end
