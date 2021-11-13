/// Existential box for any ImpartialGame.
public struct AnyImpartialGame: ImpartialGame, CustomStringConvertible {
    let value: AnyHashable
    let getPlays: (AnyHashable) -> [AnyImpartialGame]

    init<G: ImpartialGame>(_ game: G) {
        if let game = game as? AnyImpartialGame {
            self = game
            return
        }

        value = AnyHashable(game)
        getPlays = { value in (value as! G).plays.map({ AnyImpartialGame($0) }) }
    }

    public var plays: [AnyImpartialGame] { getPlays(value) }

    public var description: String { "\(value)" }

    public func hash(into hasher: inout Hasher) { hasher.combine(value) }

    public static func == (lhs: AnyImpartialGame, rhs: AnyImpartialGame) -> Bool {
        return lhs.value == rhs.value
    }
}
