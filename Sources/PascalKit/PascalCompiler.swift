public final class PascalCompiler {
    public init() {}
    
    public func run(_ source: String) -> String {
        let lexer = Lexer(source)
        let parser = Parser(lexer: lexer)
        let result = parser.parse()
        return "\(result)"
    }
}
