/// Represents a game of _King_.
///
/// King is a game played on an infite infinite chess-board with cells numbered staring from (0, 0). The cell with index (x, y) is located in column x and row y. In each play, the rook must move either one square horizontally, vertically or diagonally towards row/column 0.
///
/// A game position is represented as `K<x>,<y>` where `<x>` and `<y>` are the column and row numbers, respectively, of the king's current cell, e.g. `K1,2`.
public struct King: ImpartialGame, CustomStringConvertible {
    let x: Int
    let y: Int

    public init(_ x: Int, _ y: Int) {
        precondition(x >= 0 && y >= 0)

        self.x = x
        self.y = y
    }

    public var plays: [King] {
        var plays: [King] = []

        for (x, y) in [(x - 1, y), (x - 1, y - 1), (x, y - 1)] {
            if x >= 0 && y >= 0 {
                plays.append(King(x, y))
            }
        }

        return plays
    }

    public var description: String { "K\(x),\(y)" }
}
