struct King: ImpartialGame {
    let x: Int
    let y: Int

    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }

    var plays: [King] {
        var plays: [King] = []

        for (x, y) in [(x - 1, y), (x - 1, y - 1), (x, y - 1)] {
            if x >= 0 && y >= 0 {
                plays.append(King(x, y))
            }
        }

        return plays
    }
}
