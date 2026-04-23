public final class Parser {
    private let lexer: Lexer
    private var currentToken: Token
    
    public init(lexer: Lexer) {
        self.lexer = lexer
        self.currentToken = lexer.getNextToken()
    }
    
    private func eat(_ token: Token) {
        switch (token, currentToken) {
        case (.number, .number):
            currentToken = lexer.getNextToken()
            
        case _ where token == currentToken:
            currentToken = lexer.getNextToken()
            
        default:
            fatalError("Invalid syntax: expected \(token), got \(currentToken)")
        }
    }
    
    private func factor() -> Int {
        switch currentToken {
        case .number(let value):
            eat(.number(0)) // match any number safely
            return value
            
        case .lparen:
            eat(.lparen)
            let result = expr()
            eat(.rparen)
            return result
            
        default:
            fatalError("Unexpected token: \(currentToken)")
        }
    }
    
    private func term() -> Int {
        var result = factor()
        
        while currentToken == .multiply || currentToken == .divide {
            let token = currentToken
            
            if token == .multiply {
                eat(.multiply)
                result *= factor()
            } else {
                eat(.divide)
                result /= factor()
            }
        }
        
        return result
    }
    
    private func expr() -> Int {
        var result = term()
        
        while currentToken == .plus || currentToken == .minus {
            let token = currentToken
            
            if token == .plus {
                eat(.plus)
                result += term()
            } else {
                eat(.minus)
                result -= term()
            }
        }
        
        return result
    }
    
    public func parse() -> Int {
        return expr()
    }
}
