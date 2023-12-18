import Foundation

enum OperationList: String {
    case Plus = "＋"
    case Minus = "﹣"
    case Multiply = "×"
    case Divide = "÷"
    case Negative = "±"
    case AllClean = "AC"
    case Eqaul = "="
    case Percentage = "﹪"
}

enum DigitList: String {
    case One = "1"
    case Two = "2"
    case Three = "3"
    case Four = "4"
    case Five = "5"
    case Six = "6"
    case Seven = "7"
    case Eight = "8"
    case Nine = "9"
    case Zero = "0"
    case Dot = "."
}

struct Constants {
    static let decimalPoint: String = "."
    static let emptyString: String = ""
    static let maxStringLength: Int = 8
    static let pointAfterZero: String = "0."
}
