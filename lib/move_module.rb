module SlidingPiece
  # for bishop, rook, queen

  DIAG_MOVES_DIFF = [[1,1],[1,-1],[-1,1],[-1,-1]]
  NORMAL_MOVES_DIFF = [[1,0],[-1,0],[0,1],[0, -1]]

  def slide_moves(start_pos, dirc)
    moves = []
    next_position = add_diff(start_pos, dirc)
    until out_bounds_or_own?(next_position)
      moves += [next_position]
      break if enemy?(next_position)
      new_position = add_diff(next_position, dirc)
      next_position = new_position
    end
      moves
  end

  def add_diff(start_pos, diff)
    row_idx = diff.first + start_pos.first
    col_idx = diff.last + start_pos.last
    [row_idx, col_idx]
  end
end

module SteppingPiece
  #knight, king

  KNIGHT_MOVES_DIFF = [[-2,1], [2, -1], [2,1], [-2,-1],[-1,2],[1,-2],[-1,-2],[1,2]]
  KING_MOVES_DIFF = [[0,1],[1,1],[1,0],[1,-1],[0,-1],[-1,-1],[-1,0],[-1,1]]

  def knight_moves(start_pos)
    moves = []
    own_color = self.color
    KNIGHT_MOVES_DIFF.each do |diff|
      y = diff.first + start_pos.first
      x = diff.last + start_pos.last
      new_position = [y, x]
      next if !board.in_bounds?(new_position) || board.occupied?(new_position, own_color)
      moves << [y, x]
    end
    # debugger
    moves
  end

  def king_moves(start_pos)
    moves = []
    KING_MOVES_DIFF.each do |diff|
      y = diff.first - start_pos.first
      x = diff.last - start_pos.last
      next if !board.in_bounds?([y,x]) || board.occupied?([y,x], self.color)
      moves << [y, x]
    end
    moves
  end
end #module end
