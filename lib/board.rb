require_relative "piece"
require_relative "display"

class Board
  attr_accessor :grid
  def initialize(setup = true)
    @grid = Array.new(8) { Array.new(8) { NullPiece.new(nil, nil, self) } }
    populate if setup == true
  end

  def populate
    #black
      #pawn
    @grid[1].each_with_index do |pawn_space, index|
      @grid[1][index] = Pawn.new("black", [1,index], self)
    end
      #rook
    @grid[0][0] = Rook.new("black",[0,0], self)
    @grid[0][7] = Rook.new("black",[0,7], self)
    #knight
    @grid[0][1] = Knight.new("black",[0,1], self)
    @grid[0][6] = Knight.new("black",[0,6], self)
    #bishop
    @grid[0][2] = Bishop.new("black",[0,2], self)
    @grid[0][5] = Bishop.new("black",[0,5], self)
    #queen
    @grid[0][3] = Queen.new("black",[0,3], self)
    #king
    @grid[0][4] = King.new("black",[0,4], self)
  #white
      #pawn
    @grid[6].each_with_index do |pawn_space, index|
      @grid[6][index] = Pawn.new("white", [1,index],self)
    end
    #rock
    @grid[7][0] = Rook.new("white",[7,0],self)
    @grid[7][7] = Rook.new("white",[7,7],self)
    #knight
    @grid[7][1] = Knight.new("white",[7,1],self)
    @grid[7][6] = Knight.new("white",[7,6],self)
    #bishop
    @grid[7][2] = Bishop.new("white",[7,2],self)
    @grid[7][5] = Bishop.new("white",[7,5],self)
    #queen
    @grid[7][3] = Queen.new("white",[7,3],self)
    #king
    @grid[7][4] = King.new("white",[7,4],self)
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end
  #piece class will verify if it is a valid move
  def in_check(color)
      #find_king(color)
      #check all moves for king_pos
  end

  def checkmate(color)
    #no more valid moves for king
  end

  def board_dup(false)
    # board_dup = self.dup
    # iterate thru board_dup, for each spot,  do piece.dup and pass board_dup
    new_board = Board.new(false)
    self.grid.each_with_index do |row, row_idx|
      grid.each_with_index do |piece, col_idx|
        new_board[row_idx][col_idx] = piece.piece_dup(new_board)
      end
    end
    new_board
  end
  ###################
  def move_piece(start, end_pos)

    if board[start].valid_move?(start, end_pos)
      #move piece
      board[end_pos] = board[start]
      board[start] = NullPiece.new(nil, nil, self)
    else
      #raise error
    end
  end


  def blocked_route?(start, end_pos, pos_moves)
    #after making sure that end_pos is one of the possible moves, check that the route is clear
    # consider whether blocked by own color or opp color
    pos_moves.each do |move|
      if board[end_pos].color == board[start].color
        return true
      elsif move.first > start.first && move.first < end_pos.first && move.last > start.last && move.last < end_pos.last
        return true if board[move].class != NullPiece
      end
    end
    false
  end

  # def occupied?(end_pos)
  #   # if occupied true, return piece. if false, return false
  #   if @grid[end_pos].is_a?(NullPiece)
  #     false
  #   elsif @grid[end_pos].color != current_player.color
  #     false
  #   else
  #     true
  #   end

    # @grid[end_pos].open = true


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
end

new_board = Board.new
new_display = Display.new(new_board)
new_display.render
