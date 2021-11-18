<!-- Generated from file /Users/michi/Documents/Projects/Hackenbush/CombinatorialGames/Sources/Examples/main.swift -->

# CombinatorialGames API

These examples are contained in the source file [Sources/Examples/main.swift](Sources/Examples/main.swift), which is contained in a runnable target called `Examples`. When run, the target will print a Markdown-formatted version of the source file which combines the source code, markup from `///`-prefixed comments and the representations of the values passed to `show()`.

The output is written to the file `Examples.md` and checked in. It can be update using the following command:

```sh
swift run Examples > Examples.md
```

## Examples

```swift
import CombinatorialGames
import ExampleMonster
```

## Game values

Games are values. This constructs a Game with a single, diagonally-impaired king at position `(1, 2)`.
```swift
show(King(1, 2))
// K1,2: King
```

`Game.plays` returns the list of possible continuation of a game, in this case the 3 movements allowed by the king.
```swift
show(King(1, 2).plays)
// [K0,2, K0,1, K1,1]: Array<King>
```

Games can be added.
```swift
let game = show(show(King(1, 2)) + show(BabyRook(5)))
// K1,2: King
// r5: BabyRook
// K1,2 + r5: ImpartialGameSum<King, BabyRook>
```

`Game.firstPlayerWins` returns whether the first player could win if this game was played.
```swift
show(game.firstPlayerWins)
// true: Bool
```

`Game.winningPlays` return the continuations which allow the first player to win.
```swift
show(game.winningPlays)
// [K1,2 + r3]: Array<ImpartialGameSum<King, BabyRook>>
```

`BabyRook` games can be used to represent individual heaps in a game of _Nim_. This is a game with four heaps of different size.
```swift
let game2 = BabyRook(7) + BabyRook(5) + BabyRook(3) + BabyRook(1)
```

`Game.reducedGameValue` tries to find a game of `BabyRook` with the same value as the game and returns it.

```swift
show("\(game2) ~ \(game2.reducedGameValue)")
// r7 + r5 + r3 + r1 ~ r0
```

The result indicates indicating that this game of Nim is equivalent to a baby rook without any available moves, which means that the player taking the first turn will lose.

The `~` operator can be used to test whether two game positions are equivalent, i.e. have the same game value.
```swift
show(game ~ game2.plays[1])
// true: Bool
```
