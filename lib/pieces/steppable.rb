module Steppable
  #knight, king

  KNIGHT_MOVES_DIFF = [[-2,1], [2, -1], [2,1], [-2,-1],[-1,2],[1,-2],[-1,-2],[1,2]]
  KING_MOVES_DIFF = [[0,1],[1,1],[1,0],[1,-1],[0,-1],[-1,-1],[-1,0],[-1,1]]

  def step_moves(start_pos, diff_type)
    moves = diff_type.map do |dirc|
      next_position = add_diff(start_pos, dirc)
      next if out_bounds_or_own?(next_position)
      next_position
    end
    moves.select { |move| !move.nil? }
  end
end
