/// # CombinatorialGames API
///
/// These examples are contained in the source file [Sources/Examples/main.swift](), which is contained in a runnable target called `Examples`. When run, the target will print a Markdown-formatted version of the source file which combines the source code, markup from `///`-prefixed comments and the representations of the values passed to `show()`.
///
/// The output is written to the file `Examples.md` and checked in. It can be update using the following command:
///
/// ```sh
/// swift run Examples > Examples.md
/// ```
///
/// ## Examples
///
import CombinatorialGames
import ExampleMonster
///
/// ## Game values
///
/// Games are values. This constructs a Game with a single, diagonally-impaired king at position `(1, 2)`.
show(King(1, 2))
///
/// `Game.plays` returns the list of possible continuation of a game, in this case the 3 movements allowed by the king.
show(King(1, 2).plays)
///
/// Games can be added.
let game = show(show(King(1, 2)) + show(BabyRook(5)))
///
/// `Game.firstPlayerWins` returns whether the first player could win if this game was played.
show(game.firstPlayerWins)
///
/// `Game.winningPlays` return the continuations which allow the first player to win.
show(game.winningPlays)
///
/// `BabyRook` games can be used to represent individual heaps in a game of _Nim_. This is a game with four heaps of different size.
let game2 = BabyRook(7) + BabyRook(5) + BabyRook(3) + BabyRook(1)
///
/// `Game.reducedGameValue` tries to find a game of `BabyRook` with the same value as the game and returns it.
///
show("\(game2) ~ \(game2.reducedGameValue)")
///
/// The result indicates indicating that this game of Nim is equivalent to a baby rook without any available moves, which means that the player taking the first turn will lose.
///
/// The `~` operator can be used to test whether two game positions are equivalent, i.e. have the same game value.
show(game ~ game2.plays[1])
