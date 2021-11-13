let game = (BabyRook(5) + King(1, 2))

print("\(game): \(firstPlayerWins(game: game))")

for i in game.plays {
    print("\(i): \(firstPlayerWins(game: i))")
}
