protocol ImpartialGame: Hashable {
    var plays: [Self] { get }
}

extension ImpartialGame {
    var firstPlayerWins: Bool {
        FirstPlayerWins.firstPlayerWins(self)
    }

    var reducedGameValue: BabyRook {
        for i in 0...100 {
            let rook = BabyRook(i)

            if !(self + rook).firstPlayerWins {
                return rook
            }
        }

        /// We have to stop at some point. The algorithm is the most stupid possible anyways.
        fatalError("¯\\_(ツ)_/¯")
    }
}

/// Encapsulate state used by `firstPlayerWins()` for caching results.
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
