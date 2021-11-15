infix operator ~ : ComparisonPrecedence

/// Describes the initial state of an impartial game.
///
/// An impartial game is played by 2 players taking turns. The first player unable to make a valid move looses. An example of such a game is the game of _Nim_.
public protocol ImpartialGame: Hashable {
    /// A list of available continuations of the player taking the first turn.
    var plays: [Self] { get }
}

extension ImpartialGame {
    /// Whether the first player can win the game when playing perfectly.
    ///
    /// The computed results for this property are cached for the duration of the runtime of the program.
    public var firstPlayerWins: Bool {
        return FirstPlayerWins.firstPlayerWins(self)
    }

    /// The subset of plays that allow the first player to win. These are considered the "perfect" plays.
    public var winningPlays: [Self] {
        return plays.filter({ !$0.firstPlayerWins })
    }

    /// Find a game of _Baby Rook_ with the same value as the this game.
    public var reducedGameValue: BabyRook {
        for i in 0...100 {
            let rook = BabyRook(i)

            if self ~ rook {
                return rook
            }
        }

        /// We have to stop at some point. The algorithm is the most stupid possible anyways.
        fatalError("¯\\_(ツ)_/¯")
    }
}

/// Returns `true` if the two games are equivalent in terms of their value.
public func ~<G1: ImpartialGame, G2: ImpartialGame>(left: G1, right: G2) -> Bool {
    /// Two games are equivalent if they cancel each other out when adding them. If they do, it means that the second player wins. I.e. their sum has the value of `0`.
    return !(left + right).firstPlayerWins
}

/// Encapsulate state used by `Game.firstPlayerWins()` for caching results.
fileprivate enum FirstPlayerWins {
    static var cache: [AnyHashable:Bool] = [:]
    static var walking: Set<AnyHashable> = []

    static func firstPlayerWins<G: ImpartialGame>(_ game: G) -> Bool {
        if let result = cache[game] {
            return result
        }

        let inserted = walking.insert(game).inserted
        precondition(inserted, "Recursive call leading up to \(game)")

        let result = !game.plays.allSatisfy(firstPlayerWins)
        cache[game] = result

        defer { walking.remove(game) }
        return result
    }
}
