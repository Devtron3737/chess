require_relative 'module'
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
      color = self.color


      self.moves(start_pos).each do |move|
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

  MOVE_UP = [[2,0],[1,0]]
  DIAG = [[1, -1], [1, 1]]
  def moves(start_pos)
    moves = []
    # debugger
    MOVE_UP.each do |pos|
      #change pawn's moved instance variable after being moved
      next if self.moved
      # debugger
      if self.color == "black"
        row_idx = pos.first + start_pos.first
        col_idx = pos.last + start_pos.last

        moves += [[row_idx, col_idx]] if board.in_bounds?([row_idx, col_idx]) && board.grid[row_idx][col_idx].is_a?(NullPiece)
      else
        row_idx = pos.first - start_pos.first
        col_idx = pos.last - start_pos.last
        moves += [[row_idx, col_idx]] if board.in_bounds?([row_idx, col_idx]) && board.grid[row_idx][col_idx].is_a?(NullPiece)
      end
    end
    if moved
      DIAG.each do |pos|
        if self.color == "black"
          row_idx = pos.first + start_pos.first
          col_idx = pos.last + start_pos.first
          moves += [[row_idx, col_idx]] if board.in_bounds?([row_idx, col_idx]) && board.grid[row_idx][col_idx].color != self.color
        else
          row_idx = pos.first - start_pos.first
          col_idx = pos.last - start_pos.first
          moves += [[row_idx, col_idx]] if board.in_bounds?([row_idx, col_idx]) && board.grid[row_idx][col_idx].color != self.color
        end
      end
    end
    moves
  end


end

class Bishop < Piece
  include SlidingPiece
  def to_s
    color == "white" ? " \u2657 " : " \u265d "
  end

  def moves(start_pos)
    pos_moves = []
    DIAG_MOVES_DIFF.each do |dirc|
      pos_moves += slide_moves(start_pos, dirc)
    end
    pos_moves
  end
end

class Rook < Piece
  include SlidingPiece

  def to_s
    color == "white" ? " \u2656 " : " \u265c "
  end

  def moves(start_pos)
    pos_moves = []
    NORMAL_MOVES_DIFF.each do |dirc|
      pos_moves += slide_moves(start_pos, dirc)
    end
    pos_moves
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

class Queen < Piece
  include SlidingPiece
  def to_s
    color == "white" ? " \u2655 " : " \u265b "
  end
    #print out pos moves without in_check or end_pos check
  def moves(start_pos)
    pos_moves = []
    (DIAG_MOVES_DIFF + NORMAL_MOVES_DIFF).each do |dirc|
      pos_moves += slide_moves(start_pos, dirc)
    end
    pos_moves
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
