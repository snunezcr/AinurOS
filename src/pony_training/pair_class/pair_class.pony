class Pair
  var _x: U32 = 0
  var _y: U32 = 0

  new create(x: U32, y: U32) =>
    _x = x
    _y = y

  // Define addition operation
  fun add (other: Pair): Pair =>
    Pair(_x + other._x, _y + other._y)

class Adder
  fun test() =>
    var x = Pair(1, 2)
    var y = Pair(3, 4)
    var z = x + y
