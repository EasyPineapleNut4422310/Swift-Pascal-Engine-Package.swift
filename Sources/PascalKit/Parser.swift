public final class Parser {
    private let lexer: Lexer
    private var currentToken: Token
    
    public init(lexer: Lexer) {
        self.lexer = lexer
        self.currentToken = lexer.getNextToken()
    }
    
    private func eat(_ token: Token) {
        if case token = currentToken {
            currentToken = lexer.getNextToken()
        } else {
            fatalError("Invalid syntax")
        }
    }
    
    private func factor() -> Int {
        switch currentToken {
        case .number(let value):
            eat(currentToken)
            return value
            
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
        
        while currentToken == .multiply || currentToken == .divide {
            let token = currentToken
            eat(token)
            
            if token == .multiply {
                result *= factor()
            } else {
                result /= factor()
            }
        }
        
        return result
    }
    
    private func expr() -> Int {
        var result = term()
        
        while currentToken == .plus || currentToken == .minus {
            let token = currentToken
            eat(token)
            
            if token == .plus {
                result += term()
            } else {
                result -= term()
            }
        }
        
        return result
    }
    
    public func parse() -> Int {
        return expr()
    }
}
