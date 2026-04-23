public final class Parser {
    private let lexer: Lexer
    private var currentToken: Token
    
    public init(lexer: Lexer) {
        self.lexer = lexer
        self.currentToken = lexer.getNextToken()
    }
    
    private func eatNumber() -> Int {
        if case let .number(value) = currentToken {
            currentToken = lexer.getNextToken()
            return value
        }
        fatalError("Expected number")
    }
    
    private func eat(_ expected: Token) {
        switch (expected, currentToken) {
        case (.plus, .plus),
             (.minus, .minus),
             (.multiply, .multiply),
             (.divide, .divide),
             (.lparen, .lparen),
             (.rparen, .rparen):
            
            currentToken = lexer.getNextToken()
            
        default:
            fatalError("Invalid syntax")
        }
    }
    
    private func factor() -> Int {
        switch currentToken {
        case .number:
            return eatNumber()
            
        case .lparen:
            eat(.lparen)
            let result = expr()
            eat(.rparen)
            return result
            
        default:
            fatalError("Unexpected token")
        }
    }
    
    private func term() -> Int {
        var result = factor()
        
        while true {
            switch currentToken {
            case .multiply:
                eat(.multiply)
                result *= factor()
                
            case .divide:
                eat(.divide)
                result /= factor()
                
            default:
                return result
            }
        }
    }
    
    private func expr() -> Int {
        var result = term()
        
        while true {
            switch currentToken {
            case .plus:
                eat(.plus)
                result += term()
                
            case .minus:
                eat(.minus)
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
public final class PascalCompiler {
    public init() {}
    
    public func run(_ source: String) -> String {
        let lexer = Lexer(source)
        let parser = Parser(lexer: lexer)
        let result = parser.parse()
        return "\(result)"
    }
}
