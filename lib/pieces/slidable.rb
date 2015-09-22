module Slidable
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
end
