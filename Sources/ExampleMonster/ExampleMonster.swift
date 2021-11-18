import Foundation

fileprivate var outputsByLineByFile: [String:[Int:[String]]] = [:]

fileprivate enum SourceLine {
    case code(String)
    case markdownComment(String)
}

fileprivate func getSourceLines(_ source: String) -> [SourceLine] {
    var lines: [SourceLine] = []

    for var line in source.components(separatedBy: "\n") {
        if line.starts(with: "///") {
            line.removeFirst(3)

            if line.starts(with: " ") {
                line.removeFirst()
            }

            lines.append(.markdownComment(line))
        } else {
            lines.append(.code(line))
        }
    }

    return lines
}

fileprivate func loadSourceFile(_ filePath: String) -> String {
    do {
        return try String(contentsOfFile: filePath)
    } catch {
        fatalError("Reading source file \(filePath) failed: \(error)")
    }
}

fileprivate func printLines<C: Collection>(_ lines: C) where C.Element == String {
    for i in lines {
        print(i)
    }
}

fileprivate func processSourceFile(filePath: String) {
    let outputsByLine = outputsByLineByFile[filePath] ?? [:]
    let lines = getSourceLines(loadSourceFile(filePath))

    var codeLines: [String] = []

    func printCodeLines() {
        let blankPrefix = codeLines.prefix(while: \.isEmpty)
        let rest = codeLines.suffix(from: blankPrefix.count)

        var nonBlank = rest.prefix(while: { !$0.isEmpty })
        let blankSuffix = rest.suffix(from: rest.count)

        if !nonBlank.isEmpty { nonBlank = ["```swift"] + nonBlank + ["```"] }
        for i in blankPrefix + nonBlank + blankSuffix { print(i) }

        codeLines = []
    }

    print("<!-- Generated from file \(filePath) -->")
    print()

    for (lineNumber, line) in lines.enumerated() {
        switch line {
        case let .code(source):
            codeLines.append(source)
            codeLines.append(contentsOf: outputsByLine[lineNumber] ?? [])
        case let .markdownComment(content):
            printCodeLines()
            print(content)
        }
    }

    printCodeLines()
}

fileprivate let initialized: Void = ({
    /// Register an exit handler to print all the gathered output when the process terminates.
    atexit {
        for filePath in outputsByLineByFile.keys.sorted() {
            processSourceFile(filePath: filePath)
        }
    }
})()

func addOutput(_ output: String, _ filePath: String, _ lineNumber: Int, _ columnNumber: Int) {
    /// The closure in the definition of this variable is executed the first time the variable is accessed.
    _ = initialized

    let padding = String(repeating: " ", count: max(0, columnNumber - 3))

    outputsByLineByFile[filePath, default: [:]][lineNumber - 1, default: []].append("//\(padding) ^ \(output)")
}
