import CombinatorialGames

let game = (BabyRook(5) + King(1, 2))

print("\(game): \(game.firstPlayerWins)")

for i in game.plays {
    print("\(i): \(game.firstPlayerWins)")
}

/// Basically a nim game.
let game2 = BabyRook(7) + BabyRook(5) + BabyRook(3) + BabyRook(1)

print(game2.reducedGameValue)
