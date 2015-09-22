require_relative 'piece'

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

  private

  def pawn_vertical_moves(start_pos)
    moves = []
    diff = vertical_diff_determiner
    new_position = add_diff(start_pos, diff)
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
        new_position = add_diff(position, diag_pos)
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
