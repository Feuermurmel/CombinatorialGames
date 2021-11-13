struct BabyRook: ImpartialGame {
    let position: Int

    init(_ position: Int) {
        self.position = position
    }

    var plays: [BabyRook] {
        return (0..<position).map({ BabyRook($0) })
    }
}
