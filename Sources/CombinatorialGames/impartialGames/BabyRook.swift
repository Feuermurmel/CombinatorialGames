public struct BabyRook: ImpartialGame, CustomStringConvertible {
    let position: Int

    public init(_ position: Int) {
        self.position = position
    }

    public var plays: [BabyRook] {
        return (0..<position).map({ BabyRook($0) })
    }

    public var description: String { "r\(position)" }
}
