module SlidingPiece
  #bishop, rook, queen


 # Dry out functionality into slide
  def diag_moves(start_pos) # this returns array of every move possible from one spot (not considering end_pos)
    moves = []
    x , y = start_pos
    #x & y, and run loop until x || y go off board
    #then reset x & y for next loop
    #this will -1 vert, +1 horiz
    until x > 7 || y < 0
      moves << [x, y]
      x += 1
      y -= 1
    end
    x, y = start_pos
    #this will +1 vert, +1 horiz
    until x > 7 || y > 7
      moves << [x, y]
      x += 1
      y += 1
    end
    x, y = start_pos
    #this will +1 vert, -1 horiz
    until x < 0 || y > 7
      moves << [x, y]
      x -= 1
      y += 1
    end
    x, y = start_pos
    #this will -1 vert, -1 horiz
    until x < 0 || y < 0
      moves << [x, y]
      x -= 1
      y -= 1
    end
    moves.uniq
  end


  # Dry out
  def vert_moves(start_pos) # this generates every move possible from one spot (not considering end_pos)
    moves = []
    x , y = start_pos
    #x & y, and run loop until x || y go off board
    #then reset x & y for next loop
    #this will -1 vert, +1 horiz
    until y < 0
      moves << [x, y]
      y -= 1
    end
    x, y = start_pos
    #this will +1 vert, +1 horiz
    until y > 7
      moves << [x, y]
      y += 1
    end
    moves.uniq
  end

  def horiz_moves(start_pos) # this generates every move possible from one spot (not considering end_pos)
    moves = []
    x , y = start_pos
    #x & y, and run loop until x || y go off board
    #then reset x & y for next loop
    #this will -1 vert, +1 horiz
    until x < 0
      moves << [x, y]
      x -= 1
    end
    x, y = start_pos
    #this will +1 vert, +1 horiz
    until x > 7
      moves << [x, y]
      x += 1
    end
    moves.uniq
  end

end

module SteppingPiece
  #knight, king
  def knight_moves(start_pos)
    KNIGHT_MOVES_DIFF = [[-2,1], [2, -1], [2,1], [-2,-1],[-1,2],[1,-2],[-1,-2],[1,2]]
    moves = []
    KNIGHT_MOVES_DIFF.each do |diff|
      x = diff.first - start_pos.first
      y = diff.last - start_pos.last
      moves << [x, y]
    end
    moves
  end

  def king_moves(start_pos)
    KING_MOVES_DIFF = [[0,1],[1,1],[1,0],[1,-1],[0,-1],[-1,-1],[-1,0],[-1,1]]
    moves = []
    KING_MOVES_DIFF.each do |diff|
      x = diff.first - start_pos.first
      y = diff.last - start_pos.last
      moves << [x, y]
    end
    moves
  end


end

module Pawn
  def pawn_moves(start_pos, end_pos, occupied)

    moves = []
    if moved
      moves = [start_pos.first, start_pos.last + 1]
    elsif moved == false
      moves  = [[start_pos.first, start_pos.last + 2], [start_pos.first, start_pos.last + 1]]
    end
    #occupied receives message from board
    if occupied
      # add diagonal moves
    end

    # what do we call occupied on without instance of board
    # third var thats passed in based on results of occupied method
    # so if occupied true, then run. dont forget to check color

    # check to see if theres a piece in the diag. if there is, add those moves
end
