/// # CombinatorialGames API
///
/// These examples are contained in the source file [Sources/Examples/main.swift](Sources/Examples/main.swift), the main file of an executable target. When run, the target will print a Markdown-formatted version of that source file, combining the source lines, the markup from `///`-prefixed comments and the values passed to `show()`.
///
/// The output has been written to the file `Examples.md` and checked in. To update it, run the following command:
///
/// ```sh
/// swift run Examples > Examples.md
/// ```
///
/// ## Introduction
///
/// > _“Begin at the beginning,”_ the King said, very gravely, _“and go on till you come to the end: then stop.”_ <br>
/// > _— Lewis Carroll, Alice in Wonderland_
///
/// We start with a few imports, one to get access to the APIs that let's us calculate with games like numbers, and one which allows us to write this executable file like a story, an interplay between a narrator, a programmer and the computer:
///
import CombinatorialGames
import ExampleMonster
///
/// The lines above are copied from the source file without anything added, as they did not specify any output to be included in the Markdown file. The line below instead specifies, that the result of `1 + 2` should be included in the output, below that line:
///
show(1 + 2)
///
/// Whenever an expression is passed to `show()`, its value and its type are show. `show()` can also be used inline as it returns the value passed to it unchanged:
///
let hello = show("HELLO")

show(show(hello + " " + show("WORLD")).count)
///
/// As you can see, the second line uses `show()` three times, and for each time, another line is added below it to show the value passed to `show()`, in execution order of the calls. The values are indent to match the column where the corresponding call to `show()` is in the source code line.
///
/// Enough of that. Now we start to calculate with some games instead of your usual numbers!
///
/// ## Game values
///
/// Games are values. This constructs a game with a single, diagonally-impaired king at position `(1, 2)`:
///
show(King(1, 2))
///
/// `Game.plays` returns the list of possible continuations of a game, in this case the 3 movements allowed by the king:
///
show(King(1, 2).plays)
///
/// Games can be added:
///
let game = show(show(King(1, 2)) + show(BabyRook(5)))
///
/// `Game.firstPlayerWins` returns whether the first player could win if this game was played:
///
show(game.firstPlayerWins)
///
/// `Game.winningPlays` return the plays which allow the first player to win:
///
show(game.winningPlays)
///
/// `BabyRook` games can be used to represent individual heaps in a game of _Nim_. This is a game with four heaps of different size:
///
let game2 = BabyRook(7) + BabyRook(5) + BabyRook(3) + BabyRook(1)
///
/// `Game.reducedGameValue` tries to find a game of `BabyRook` with the same value as the game it is called on and returns it:
///
show("\(game2) ~ \(game2.reducedGameValue)")
///
/// The result indicates indicating that this game of Nim is equivalent to a baby rook without any available moves, which means that the player taking the first turn will lose.
///
/// The `~` operator can be used to test whether two game positions are equivalent, i.e. have the same game value:
///
show(game ~ game2.plays[1])
