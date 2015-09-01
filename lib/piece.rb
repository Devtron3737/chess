class Piece
  attr_reader :color, :pos, :board
  def initialize(color, pos, board)
    @color = color
    @pos = pos
    @board = board
  end

  def present?
    true
  end

  def to_s
    " x "
  end

  def valid_move(start, end_pos, pos_moves = nil)
    #create a copy of board
    #check if the position will put us in check
    #filter out moves that will put us in check

    board_copied = board.board_dup(false)
    # if pos moves isnt nil, iterate thru pos_moves
     if !pos_moves.include?([end_pos])
       return false
     elsif
    # if our piece is on any square, dont push
    #elsif ...

    #comb through moves and select ones that are not in check and not bocked
  end

      #valid_route(start, end_pos)
      # how the pawn knows whether it is attacking or not
      # check whether place its moving to has a piece or not
      # check what color piece is





    #check what piece it is
    #have piece class check if it is valid or not
    #call valid_route? in piece class to check if it is blocked
    #in_check?


  def piece_dup(new_board)
    self.class.new(self.color, self.pos.dup, new_board)
  end
end

# print Pawn.new

class Pawn < Piece
  include Pawn
  def initialize
    @moved = false
  end

  attr_accessor :moved

  def to_s
    color == "white" ? " \u2659 " : " \u265f "
  end

  def valid_moves(start, end_pos)
    pos_moves = pawn_moves(start_pos, end_pos)
    super(start, end_pos, pos_moves)
  end


end

class Bishop < Piece
  def to_s
    color == "white" ? " \u2657 " : " \u265d "
  end
end

class Rook < Piece
  def to_s
    color == "white" ? " \u2656 " : " \u265c "
  end
end

class Knight < Piece
  def to_s
    color == "white" ? " \u2658 " : " \u265e "
  end
end

class Queen < Piece
  def to_s
    color == "white" ? " \u2655 " : " \u265b "
  end
end

class King < Piece
  def to_s
    color == "white" ? " \u2654 " : " \u265a "
  end
end

class NullPiece < Piece

  def present?
    false
  end

  def to_s
    "   "
  end
end
