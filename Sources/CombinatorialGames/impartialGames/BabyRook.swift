/// Represents a game of _Baby Rook_.
///
/// Baby Rook is a game played on a single strip of an infinite chess-board with cells numbered staring from 0. In each play, the rook must move at least one square to the left, towards the cell 0.
///
/// A game position is represented as `r<n>` where `<n>` is the cell number where the rook currently is, e.g. `r5`.
public struct BabyRook: ImpartialGame, CustomStringConvertible {
    let position: Int

    public init(_ position: Int) {
        precondition(position >= 0)

        self.position = position
    }

    public var plays: [BabyRook] {
        return (0..<position).map({ BabyRook($0) })
    }

    public var description: String { "r\(position)" }
}
