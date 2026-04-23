public final class Parser {
    private let lexer: Lexer
    private var current: Token

    public init(_ lexer: Lexer) {
        self.lexer = lexer
        self.current = lexer.nextToken()
    }

    private func advance() {
        current = lexer.nextToken()
    }

    private func factor() -> Int {
        switch current {

        case .number(let value):
            advance()
            return value

        case .lparen:
            advance()
            let result = expr()
            if case .rparen = current {
                advance()
                return result
            } else {
                fatalError("Missing ')'")
            }

        default:
            fatalError("Unexpected token")
        }
    }

    private func term() -> Int {
        var result = factor()

        while true {
            switch current {

            case .multiply:
                advance()
                result *= factor()

            case .divide:
                advance()
                result /= factor()

            default:
                return result
            }
        }
    }

    private func expr() -> Int {
        var result = term()

        while true {
            switch current {

            case .plus:
                advance()
                result += term()

            case .minus:
                advance()
                result -= term()

            default:
                return result
            }
        }
    }

    public func parse() -> Int {
        return expr()
    }
}
