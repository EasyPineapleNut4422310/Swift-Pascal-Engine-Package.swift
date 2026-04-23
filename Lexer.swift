public enum Token {
    case number(Int)
    case plus
    case minus
    case multiply
    case divide
    case lparen
    case rparen
    case eof
}

public final class Lexer {
    private let text: [Character]
    private var pos = 0

    public init(_ input: String) {
        self.text = Array(input)
    }

    private func currentChar() -> Character? {
        return pos < text.count ? text[pos] : nil
    }

    private func advance() {
        pos += 1
    }

    private func skipWhitespace() {
        while let c = currentChar(), c.isWhitespace {
            advance()
        }
    }

    private func number() -> Int {
        var result = ""
        while let c = currentChar(), c.isNumber {
            result.append(c)
            advance()
        }
        return Int(result) ?? 0
    }

    public func nextToken() -> Token {
        while let c = currentChar() {

            if c.isWhitespace {
                skipWhitespace()
                continue
            }

            if c.isNumber {
                return .number(number())
            }

            advance()

            if c == "+" { return .plus }
            if c == "-" { return .minus }
            if c == "*" { return .multiply }
            if c == "/" { return .divide }
            if c == "(" { return .lparen }
            if c == ")" { return .rparen }

            fatalError("Invalid character: \(c)")
        }

        return .eof
    }
}
