# Ruby Cursor Input

TO DO LIST

make private methods private
  private methods of a class can NEVER be called on anything outside of its class, even self
  this is because private methods cant have an explicit receiver
  they have to be called with just the name, ex: populate
  NOT grid.populate, or self.populate
  therefore, private methods are those that just help out the public methods in that class
  your internals of a class dont recieve or pass messages to other classes
  they only work for the public  methods of its own class. you CAN pass private methods args

populate board smarter (see app acad sol)

make it faster (glitchy..)
