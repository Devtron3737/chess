class Piece
  attr_reader :color
  attr_accessor :pos, :board

  def initialize(color, pos, board)
    @color = color
    @pos = pos
    @board = board
  end

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

  def move_into_check?(start_pos, end_pos)
    return true if !self.valid_moves(start_pos).include?(end_pos)
    false
  end

  def dup(new_board)
    self.class.new(color, pos.dup, new_board)
  end

  private

  def add_diff(start_pos, diff)
    row_idx = diff.first + start_pos.first
    col_idx = diff.last + start_pos.last
    [row_idx, col_idx]
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

  def out_bounds_or_own?(position)
    !board.in_bounds?(position) || own_color?(position)
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
