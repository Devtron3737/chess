require_relative 'piece'
require_relative 'slidable'
require_relative 'steppable'

class Bishop < Piece
  include Slidable

  def to_s
    color == "white" ? " \u2657 " : " \u265d "
  end

  def moves(start_pos)
    DIAG_MOVES_DIFF.map { |dirc| slide_moves(start_pos, dirc) }.flatten(1)
  end
end

class Rook < Piece
  include Slidable

  def to_s
    color == "white" ? " \u2656 " : " \u265c "
  end

  def moves(start_pos)
    NORMAL_MOVES_DIFF.map { |dirc| slide_moves(start_pos, dirc) }.flatten(1)
  end
end

class Queen < Piece
  include Slidable

  def to_s
    color == "white" ? " \u2655 " : " \u265b "
  end

  def moves(start_pos)
    (DIAG_MOVES_DIFF + NORMAL_MOVES_DIFF).map { |dirc| slide_moves(start_pos, dirc) }.flatten(1)
  end
end

class Knight < Piece
  include Steppable
  def to_s
    color == "white" ? " \u2658 " : " \u265e "
  end

  def moves(start_pos)
    step_moves(start_pos, KNIGHT_MOVES_DIFF)
  end
end



class King < Piece
  include Steppable
  def to_s
    color == "white" ? " \u2654 " : " \u265a "
  end

  def moves(start_pos)
    step_moves(start_pos, KING_MOVES_DIFF)
  end
end
