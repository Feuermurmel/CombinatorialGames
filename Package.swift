// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CombinatorialGames",
    dependencies: [],
    targets: [
        .target(name: "Examples", dependencies: ["CombinatorialGames", "ExampleMonster"]),
        .target(name: "CombinatorialGames"),
        .target(name: "ExampleMonster")])
