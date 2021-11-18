/// Add a comment line into the annotated source listing after line from which this method is called. The line describes the specified value and its type
///
/// The value is returned unchanged so that the function can be used to show intermediate values in an expression.
@discardableResult
public func show<T>(_ item: T, filePath: String = #filePath, lineNumber: Int = #line, column: Int = #column) -> T {
    addOutput("\(item): \(T.self)", filePath, lineNumber, column)

    return item
}

/// Add the specified message as a comment line into the annotated source listing after the line from which this method is called.
public func show(rawString: String, filePath: String = #filePath, lineNumber: Int = #line, column: Int = #column) {
    addOutput(rawString, filePath, lineNumber, column)
}
