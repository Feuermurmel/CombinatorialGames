func main() {
    let game = (BabyRook(5) + King(1, 2))

    print("\(game): \(firstPlayerWins(game: game))")

    for i in game.plays {
        print("\(i): \(firstPlayerWins(game: game))")
    }

    /// Basically a nim game.
    let game2 = BabyRook(7) + BabyRook(5) + BabyRook(3) + BabyRook(1)

    print(reduceGameValue(game: game2))
}

main()
