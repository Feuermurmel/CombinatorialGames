protocol ImpartialGame: Hashable {
    var plays: [Self] { get }
}

/// Encapsulate state used by `firstPlayerWins()` for caching results.
fileprivate enum FirstPlayerWins {
    static var cache: [AnyHashable:Bool] = [:]
    static var walking: Set<AnyHashable> = []

    static func firstPlayerWins<G: ImpartialGame>(game: G) -> Bool {
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

func firstPlayerWins<G: ImpartialGame>(game: G) -> Bool {
    FirstPlayerWins.firstPlayerWins(game: game)
}

func reduceGameValue<G: ImpartialGame>(game: G) -> BabyRook {
    for i in 0...100 {
        let rook = BabyRook(i)

        if !firstPlayerWins(game: game + rook) {
            return rook
        }
    }

    /// We have to stop at some point. The algorithm is the most stupid possible anyways.
    fatalError("¯\\_(ツ)_/¯")
}
