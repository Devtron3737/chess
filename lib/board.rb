require_relative 'pieces'
require_relative 'display'
require 'byebug'
require 'Set'

class Board
  attr_accessor :grid
  attr_reader :current_color

  def initialize(setup = true)
    @grid = Array.new(8) { Array.new(8) { NullPiece.new(nil, nil, self) } }
    populate if setup == true
    @current_color = ""
  end

  def in_check?(color)
    king_pos = find_king(color)
    return true if all_opponent_moves(color).include?(king_pos)
    false
  end

  def checkmate?(color)
    king_pos = find_king(color)
    king_moves = self[king_pos].moves(king_pos)
    opp_moves = all_opponent_moves(color)

    return true if in_check?(color) && all_moves_blocked?(king_moves, opp_moves)
    false
  end

  def move_piece(start_pos, end_pos)
    if nonerror_move?(start_pos, end_pos)
      self[end_pos] = self[start_pos]
      self[end_pos].pos = end_pos
      self[start_pos] = NullPiece.new(nil,nil,self)
      pawn_update(end_pos)
    end
  end

  def turn_color(color)
    @current_color = color
  end

  def move_piece!(start_pos, end_pos)
    self[end_pos] = self[start_pos]
    self[start_pos] = NullPiece.new(nil, nil, self)
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

  def all_opponent_moves(current_player_color)
    opp_moves = Set.new
    grid.each_with_index do |row, row_idx|
      row.each_with_index do |piece, col_idx|
        next if piece.color == current_player_color
        next if piece.is_a?(NullPiece)
        position = [row_idx, col_idx]
        opp_moves += piece.moves(position)
      end
    end
      opp_moves
  end

  def all_moves_blocked?(piece_moves, opp_moves)
    piece_moves.all? { |move| opp_moves.include?(move) }
  end

  def nonerror_move?(start_pos, end_pos)
    piece = self[start_pos]
      if piece.is_a?(NullPiece)
        raise 'You cant select an empty space'
      elsif piece.color != current_color
        raise 'You must move your own piece'
      elsif !piece.moves(start_pos).include?(end_pos)
        raise 'Piece cant move there because its not a space or it doesnt move like that!'
      elsif piece.move_into_check?(start_pos, end_pos)
        raise 'You cannot move into check!'
      end
    true
  end

  def pawn_update(position)
    piece = self[position]
    piece.moved = true if piece.is_a?(Pawn)
    nil
  end

  def find_king(color)
    self.grid.each_with_index do |row, row_idx|
      row.each_with_index do |piece, col_idx|
        return [row_idx, col_idx] if piece.is_a?(King) && piece.color == color
      end
    end
  end

  def populate
    populate_rooks
    populate_knights
    populate_bishops
    populate_royalty
    populate_pawns
  end

  def populate_rooks
    self[[0, 0]] = Rook.new("black",[0,0], self)
    self[[0, 7]] = Rook.new("black",[0,7], self)
    self[[7, 0]] = Rook.new("white",[7,0],self)
    self[[7, 7]] = Rook.new("white",[7,7],self)
  end

  def populate_knights
    self[[0, 1]] = Knight.new("black",[0,1], self)
    self[[0, 6]] = Knight.new("black",[0,6], self)
    self[[7, 1]] = Knight.new("white",[7,1],self)
    self[[7, 6]] = Knight.new("white",[7,6],self)
  end

  def populate_bishops
    self[[0, 2]] = Bishop.new("black",[0,2], self)
    self[[0, 5]] = Bishop.new("black",[0,5], self)
    self[[7, 2]] = Bishop.new("white",[7,2],self)
    self[[7, 5]] = Bishop.new("white",[7,5],self)
  end

  def populate_royalty
    self[[0, 3]] = Queen.new("black",[0,3], self)
    self[[0, 4]] = King.new("black",[0,4], self)
    self[[7, 3]] = Queen.new("white",[7,3],self)
    self[[7, 4]] = King.new("white",[7,4],self)
  end

  def populate_pawns
    @grid[1].each_with_index do |pawn_space, index|
      @grid[1][index] = Pawn.new("black", [1,index], self)
    end
    @grid[6].each_with_index do |pawn_space, index|
      @grid[6][index] = Pawn.new("white", [1,index],self)
    end
  end
end
