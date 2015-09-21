require_relative 'move_module'
require 'byebug'

class Piece
  attr_reader :color
  attr_accessor :pos, :board

  def initialize(color, pos, board)
    @color = color
    @pos = pos
    @board = board
  end

  # def present?
  #   true
  # end

  def to_s
    "Shouldnt be getting called on a general piece. Initalize specific piece!"
  end

  def moves(start_pos)
    puts "initialize piece!"
  end

  def valid_moves(start_pos)
      pos_moves = []
      moves(start_pos).each do |move|
        board_copy = board.dup
        board_copy.move_piece!(start_pos, move)
        pos_moves << move unless board_copy.in_check?(color)
      end
      pos_moves
   end

   def valid_move?(start_pos, end_pos)
     return true if self.valid_moves(start_pos).include?(end_pos)
     false
   end

  def dup(new_board)
    self.class.new(color, pos.dup, new_board)
  end

  def out_bounds_or_own?(position)
    !board.in_bounds?(position) || own_color?(position)
  end

  def own_color?(position)
    board[position].color == self.color
  end

  def enemy?(position)
    # debugger
    if board[position].is_a?(NullPiece)
      false
    elsif !board.in_bounds?(position)
      false
    elsif board[position].color == self.color
      false
    else
      true
    end
  end
end

# print Pawn.new

class Pawn < Piece

  def initialize(color, pos, board)
    super
    @moved = false
  end

  attr_accessor :moved

  def to_s
    color == "white" ? " \u2659 " : " \u265f "
  end

  def moves(start_pos)
    pawn_vertical_moves(start_pos).concat(pawn_diagonal_moves(start_pos))
  end

  def pawn_vertical_moves(start_pos)
    moves = []
    diff = vertical_diff_determiner
    row_idx = diff.first + start_pos.first
    col_idx = start_pos.last
    new_position = [row_idx, col_idx]
    moves = [new_position] if in_bounds_and_null_space?(new_position)
    moves += first_move_bonus(start_pos, diff) unless moved == true
    moves
  end

  def vertical_diff_determiner
    case color
      when "black"
        diff = [1, 0]
      when "white"
        diff = [-1, 0]
    end
    diff
  end

  def in_bounds_and_null_space?(position)
    board.in_bounds?(position) && board[position].is_a?(NullPiece)
  end

  def first_move_bonus(start_pos, diff)
    row_idx, col_idx = start_pos.first, start_pos.last
    new_row_idx = row_idx + (diff.first * 2)
    new_position = [new_row_idx, col_idx]
    return [new_position] if in_bounds_and_null_space?(new_position)
    []
  end

  def pawn_diagonal_moves(position)
    row_idx, col_idx = position.first, position.last
    diff = diangonal_diff_determiner
    positions = diff.map do |diag_pos|
        new_row_idx = row_idx + diag_pos.first
        new_col_idx = col_idx + diag_pos.last
        new_position = [new_row_idx, new_col_idx]
        next unless enemy?(new_position)
        diag_pos = new_position
    end
    positions.select { |pos| !pos.nil? }
  end

  def diangonal_diff_determiner
    case color
      when "black"
        diff = [[1, 1], [1, -1]]
      when "white"
        diff = [[-1, 1], [-1, -1]]
    end
    diff
  end
end

class Bishop < Piece
  include SlidingPiece

  def to_s
    color == "white" ? " \u2657 " : " \u265d "
  end

  def moves(start_pos)
    DIAG_MOVES_DIFF.map { |dirc| slide_moves(start_pos, dirc) }.flatten(1)
  end
end

class Rook < Piece
  include SlidingPiece

  def to_s
    color == "white" ? " \u2656 " : " \u265c "
  end

  def moves(start_pos)
    NORMAL_MOVES_DIFF.map { |dirc| slide_moves(start_pos, dirc) }.flatten(1)
  end
end

class Queen < Piece
  include SlidingPiece

  def to_s
    color == "white" ? " \u2655 " : " \u265b "
  end

  def moves(start_pos)
    (DIAG_MOVES_DIFF + NORMAL_MOVES_DIFF).map { |dirc| slide_moves(start_pos, dirc) }.flatten(1)
  end
end

class Knight < Piece
  include SteppingPiece
  def to_s
    color == "white" ? " \u2658 " : " \u265e "
  end

  def moves(start_pos)
    knight_moves(start_pos)
  end
end



class King < Piece
  include SteppingPiece
  def to_s
    color == "white" ? " \u2654 " : " \u265a "
  end

  def moves(start_pos)
    king_moves(start_pos)
  end
end

class NullPiece < Piece

  def present?
    false
  end

  def to_s
    "   "
  end

  def pos
    []
  end

  def moves(start_pos)
    []
  end
end
