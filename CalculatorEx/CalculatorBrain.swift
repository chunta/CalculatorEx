import Foundation

/// Protocol representing the functionality of a calculator.
protocol ICalculatorBrain {
    /// Performs a mathematical operation based on the provided symbol.
    /// - Parameters
    ///   - symbol: The symbol representing the mathematical operation (e.g., "+", "-", "*", "/", etc.).
    func performOperation(_ symbol: String)

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
}

class CalculatorBrain: ICalculatorBrain {

    private var accumulator: Double?
    private var pendingBinaryOperation: PendingBinaryOperation?
    private var resultIsPending = false

    var description = ""
    var result: Double? { get { return accumulator } }

    // MARK: - Internal methods
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case result
    }

    private var operations: [String: Operation] = [
        OperationList.Plus.rawValue: .binaryOperation({ $0 + $1 }),
        OperationList.Minus.rawValue: .binaryOperation({ $0 - $1 }),
        OperationList.Multiply.rawValue: .binaryOperation({ $0 * $1 }),
        OperationList.Divide.rawValue: .binaryOperation({ $0 / $1 }),
        OperationList.Negative.rawValue: .unaryOperation({ -$0 }),
        OperationList.Percentage.rawValue: .unaryOperation({ $0 / 100 }),
        OperationList.AllClean.rawValue: .constant(0),
        OperationList.Eqaul.rawValue: .result
    ]

    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double

        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }

    private func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation?.perform(with: accumulator!)
            pendingBinaryOperation = nil
            resultIsPending = false
        }
    }

    // MARK: - ICalculatorBrain
    func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
                case .constant(let value):
                    accumulator = value
                    description = ""
                case .unaryOperation(let function):
                    if accumulator != nil {
                        let value = String(describing: accumulator!).removeAfterPointIfZero()
                        description = symbol + "(" + value.setMaxLength(of: 5) + ")" + "="
                        accumulator = function(accumulator!)
                    }
                case .binaryOperation(let function):
                    performPendingBinaryOperation()

                    if accumulator != nil {
                        if description.last == "=" {
                            description = String(describing: accumulator!).removeAfterPointIfZero().setMaxLength(of: 5) + symbol
                        } else {
                            description += symbol
                        }

                        pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                        resultIsPending = true
                        accumulator = nil
                    }
                case .result:
                    performPendingBinaryOperation()

                    if !resultIsPending {
                        description += "="
                    }
            }
        }
    }

    func setOperand(_ operand: Double?) {
        accumulator = operand ?? 0.0
        if !resultIsPending {
            description = String(describing: operand!).removeAfterPointIfZero().setMaxLength(of: 5)
        } else {
            description += String(describing: operand!).removeAfterPointIfZero().setMaxLength(of: 5)
        }
    }

    func sequenceExpress() -> String {
        description
    }

    func getPerformResult() -> Double? {
        accumulator
    }
}
