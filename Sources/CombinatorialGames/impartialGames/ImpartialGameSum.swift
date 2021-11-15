/// Represent the sum of two games.
///
/// In a sum of games, the players whose turn it is must make a move in exactly one of the games. The value of the sum of games is the sum of the values of the individual games.
public struct ImpartialGameSum<G1: ImpartialGame, G2: ImpartialGame>: ImpartialGame, CustomStringConvertible {
    let game1: G1
    let game2: G2

    init(_ game1: G1, _ game2: G2) {
        self.game1 = game1
        self.game2 = game2
    }

    public var plays: [ImpartialGameSum<G1, G2>] {
        return game1.plays.map({ $0 + game2 }) + game2.plays.map({ game1 + $0 })
    }

    public var description: String { "\(game1) + \(game2)" }
}

/// Return a game representing the sum of two games.
public func + <G1: ImpartialGame, G2: ImpartialGame>(left: G1, right: G2) -> ImpartialGameSum<G1, G2> {
    return ImpartialGameSum(left, right)
}
