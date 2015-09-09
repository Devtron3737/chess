# Ruby Cursor Input

TO DO LIST


refactor to have scan_pieces function in board class
see app acad solutions, had a method for returning all the boards pieces
    should take a proc (to select certain kinds of pieces, like black for ex)
    and return array of pieces (each piece should have position stored in it)

include errors for moving your piece when its not your turn, right now you can
move any piece whenever, regardless of who current player is

add update_pieces_attr method in board class
    this should iterate through board, and reinitialize each piece (necessary?)

also dont forget to update

refactor to have moves not take an argument, but just be called on self

figure out bracket methods, and refactor everything so it looks clean

create errors

make private methods private
  private methods of a class can NEVER be called on anything outside of its class, even self
  this is because private methods cant have an explicit receiver
  they have to be called with just the name, ex: populate
  NOT grid.populate, or self.populate
  therefore, private methods are those that just help out the public methods in that class
  your internals of a class dont recieve or pass messages to other classes
  they only work for the public  methods of its own class

add curser highlighting for possible moves

mess with board colors a bit
