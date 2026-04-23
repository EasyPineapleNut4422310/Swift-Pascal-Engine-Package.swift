public enum Token: Equatable {
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
    private var pos: Int = 0
    
    public init(_ input: String) {
        self.text = Array(input)
    }
    
    private func currentChar() -> Character? {
        pos < text.count ? text[pos] : nil
    }
    
    private func advance() {
        pos += 1
    }
    
    private func skipWhitespace() {
        while let char = currentChar(), char.isWhitespace {
            advance()
        }
    }
    
    private func integer() -> Int {
        var result = ""
        while let char = currentChar(), char.isNumber {
            result.append(char)
            advance()
        }
        return Int(result) ?? 0
    }
    
    public func getNextToken() -> Token {
        while let char = currentChar() {
            
            if char.isWhitespace {
                skipWhitespace()
                continue
            }
            
            if char.isNumber {
                return .number(integer())
            }
            
            advance()
            
            switch char {
            case "+": return .plus
            case "-": return .minus
            case "*": return .multiply
            case "/": return .divide
            case "(": return .lparen
            case ")": return .rparen
            default:
                fatalError("Unknown character: \(char)")
            }
        }
        
        return .eof
    }
}
