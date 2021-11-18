import Foundation

fileprivate var outputsByLineByFile: [String: [Int:[String]]] = [:]

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
    var codeLines: [String] = []
    let outputsByLine = outputsByLineByFile[filePath] ?? [:]

    func handleSourceLine(_ lineNumber: Int, _ source: String) {
        codeLines.append(source)

        for i in outputsByLine[lineNumber] ?? [] {
            codeLines.append("// \(i)")
        }
    }

    func handleMarkdownCommentLine(_ content: String) {
        let blankPrefix = codeLines.prefix(while: \.isEmpty)
        let rest = codeLines.suffix(from: blankPrefix.count)

        var nonBlank = rest.prefix(while: { !$0.isEmpty })
        let blankSuffix = rest.suffix(from: rest.count)

        if !nonBlank.isEmpty { nonBlank = ["```swift"] + nonBlank + ["```"] }
        for i in blankPrefix + nonBlank + blankSuffix + [content] { print(i) }

        codeLines = []
    }

    let lines = getSourceLines(loadSourceFile(filePath))

    print("<!-- Generated from file \(filePath) -->")
    print()

    for (lineNumber, line) in lines.enumerated() {
        switch line {
        case let .code(source): handleSourceLine(lineNumber, source)
        case let .markdownComment(content): handleMarkdownCommentLine(content)
        }
    }

    /// TODO: Print rest of `codeLines`.
}

fileprivate let initialized: Void = ({
    /// Register an exit handler to print all the gathered output when the process terminates.
    atexit {
        for filePath in outputsByLineByFile.keys.sorted() {
            processSourceFile(filePath: filePath)
        }
    }
})()

func addOutput(_ output: String, _ filePath: String, _ lineNumber: Int) {
    /// The closure in the definition of this variable is executed the first time the variable is accessed.
    _ = initialized

    outputsByLineByFile[filePath, default: [:]][lineNumber - 1, default: []].append(output)
}
