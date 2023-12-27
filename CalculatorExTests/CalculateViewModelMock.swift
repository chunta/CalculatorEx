import Foundation
@testable import CalculatorEx

class CalculateViewModelMock: ICalculatorViewModel {

    var mocksequenceExpressString: String = "MockExpress"

    var mockResult: Double = 123.45

    var allCleanCompletionHandler: (() -> Void)?

    var assistantCompletionHandler: ((String) -> Void)?

    func performOperation(_ symbol: CalculatorEx.OperatorSymbol) {
    }

    func setOperand(_ operand: Double?) {
    }

    func sequenceExpress() -> String {
        mocksequenceExpressString
    }

    func getPerformResult() -> Double? {
        mockResult
    }

    func cleanAllCalculation() {
        allCleanCompletionHandler?()
    }

    func addAssitantValue(_ value: String) {
        assistantCompletionHandler?(value)
    }
}
