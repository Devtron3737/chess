require_relative "piece"
require_relative "display"
require 'byebug'
require 'Set'

class Board
  attr_accessor :grid

  def initialize(setup = true)
    @grid = Array.new(8) { Array.new(8) { NullPiece.new(nil, nil, self) } }
    populate if setup == true
  end

  def in_check?(color)
      king_pos = find_king(color)
      grid.each_with_index do |row, row_idx|
        row.each_with_index do |piece, col_idx|
          #debugger if row_idx == 0 && col_idx == 6
          return true if piece.color != color && piece.moves([row_idx, col_idx]).include?(king_pos)
        end
      end
      false
  end

  #method scan_pieces_on_board
  # should take proc. then call proc on each space of board

      #iterate through all the moves of the other board's pieces and check if king's position is include

  def checkmate?(color)
    #no more valid moves for king
    #find all the valid moves of the king and determine if all of them are in the pos positions of the opponent
    king_pos = find_king(color) #color of the current player
    king_moves = self[king_pos].moves(king_pos)
    opp_moves = Set.new
    # debugger
    grid.each_with_index do |row, row_idx|
      row.each_with_index do |piece, col_idx|
        next if piece.color == color
        opp_moves += piece.moves([row_idx, col_idx])
      end
    end
    # debugger
    #if king moves are empty, then checkmate is false, otherwise
    king_moves.empty? ? false : king_moves.all? { |king_move| opp_moves.include?(king_move) }

  end

  def move_piece(start_pos, end_pos)

    piece = self[start_pos]
    debugger
    # if piece.color != turn_color
      # raise 'You must move your own piece'
    if !piece.moves(start_pos).include?(end_pos)
      raise 'Piece does not move like that'
    elsif !piece.valid_moves(start_pos).include?(end_pos)
      raise 'You cannot move into check'
    end
    # debugger
    if self[start_pos].valid_move?(start_pos, end_pos)
      self[end_pos] = self[start_pos]
      self[end_pos].pos = end_pos
      self[start_pos] = NullPiece.new(nil,nil,self)
    else
      # raise error
    end
  end

  def move_piece!(start_pos, end_pos)
    self[end_pos] = self[start_pos]
    self[start_pos] = NullPiece.new(nil, nil, self)
  end

  def occupied?(pos, own_color)
    # if occupied true, return piece. if false, return false
    #debugger
    if self[pos].is_a?(NullPiece)
      false
    elsif self[pos].color != own_color
      false
    else
      true
    end
  end

  def dup
    new_board = Board.new(false)
    self.grid.each_with_index do |row, row_idx|
      row.each_with_index do |piece, col_idx|
        pos = [row_idx, col_idx]
        new_board[pos] = piece.dup(new_board)
      end
    end
    new_board
  end


  def full?
    @grid.all? do |row|
      row.all? { |piece| piece.present? }
    end
  end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0, 7) }
  end

  def rows
    @grid
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end

  private

  def find_king(color)
    self.grid.each_with_index do |row, row_idx|
      row.each_with_index do |piece, col_idx|
        return [row_idx, col_idx] if piece.is_a?(King) && piece.color == color
      end
    end
  end

  def populate
    #black
      #pawn
    @grid[1].each_with_index do |pawn_space, index|
      @grid[1][index] = Pawn.new("black", [1,index], self)
    end
      #rook
    self[[0, 0]] = Rook.new("black",[0,0], self)
    self[[0, 7]] = Rook.new("black",[0,7], self)
    #knight
    self[[0, 1]] = Knight.new("black",[0,1], self)
    self[[0, 6]] = Knight.new("black",[0,6], self)
    #bishop
    # self[[0, 2]] = Bishop.new("black",[0,2], self)
    self[[3, 3]] = Bishop.new("black",[3,3], self) #test pos
    self[[0, 5]] = Bishop.new("black",[0,5], self)
    #queen
    self[[0, 3]] = Queen.new("black",[0,3], self)
    #king
    self[[0, 4]] = King.new("black",[0,4], self)
  #white
      #pawn
    @grid[6].each_with_index do |pawn_space, index|
      @grid[6][index] = Pawn.new("white", [1,index],self)
    end
    #rock
    self[[7, 0]] = Rook.new("white",[7,0],self)
    self[[7, 7]] = Rook.new("white",[7,7],self)
    #knight
    self[[7, 1]] = Knight.new("white",[7,1],self)
    self[[7, 6]] = Knight.new("white",[7,6],self)
    #bishop
    self[[7, 2]] = Bishop.new("white",[7,2],self)
    self[[7, 5]] = Bishop.new("white",[7,5],self)
    #queen
    self[[7, 3]] = Queen.new("white",[7,3],self)
    #king
    self[[7, 4]] = King.new("white",[7,4],self)
  end

end

new_board = Board.new
new_display = Display.new(new_board)
new_display.render
