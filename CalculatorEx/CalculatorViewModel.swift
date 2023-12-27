import Foundation

/// Protocol defining the interface for a calculator view model.
protocol ICalculatorViewModel: AnyObject {
    /// Performs a mathematical operation based on the provided symbol.
    /// - Parameter 
    ///   - symbol: The symbol representing the mathematical operation (e.g., "+", "-", "*", "/", etc.).
    func performOperation(_ symbol: OperatorSymbol)

    /// Sets the operand (numeric value) for calculations.
    /// - Parameter 
    ///   - operand: The numeric value to be used as an operand in calculations.
    func setOperand(_ operand: Double?)

    /// Generates a string representing the sequence of operations and operands performed.
    /// - Returns: A string expression of the performed operations and operands.
    func sequenceExpress() -> String

    /// Retrieves the result of the performed mathematical operations.
    /// - Returns: The result of the calculations performed, if available.
    func getPerformResult() -> Double?

    func cleanAllCalculation()

    /// Notifies the view model about an additional value from an assistant (if available).
    /// - Parameter 
    ///   - value: The value received from the assistant, if any.
    func addAssitantValue(_ value: String)

    /// Closure variable representing an 'AC' completion handler.
    var allCleanCompletionHandler: (() -> Void)? { get set }

    var assistantCompletionHandler: ((String) -> Void)? { get set }
}

class CalculatorViewModel: ICalculatorViewModel {

    var allCleanCompletionHandler: (() -> Void)?

    var assistantCompletionHandler: ((String) -> Void)?

    private var calculatorBrain: ICalculatorBrain!

    init(_ calculatorBrain: ICalculatorBrain = CalculatorBrain()) {
        self.calculatorBrain = calculatorBrain
    }

    func performOperation(_ symbol: OperatorSymbol) {
        calculatorBrain.performOperation(symbol.rawValue)
    }

    func setOperand(_ operand: Double?) {
        calculatorBrain.setOperand(operand)
    }

    func sequenceExpress() -> String {
        calculatorBrain.sequenceExpress()
    }

    func getPerformResult() -> Double? {
        calculatorBrain.getPerformResult()
    }

    func cleanAllCalculation() {
        calculatorBrain.performOperation(OperatorSymbol.AllClean.rawValue)
        allCleanCompletionHandler?()
    }

    func addAssitantValue(_ value: String) {
        assistantCompletionHandler?(value)
    }
}
