import Foundation
@testable import CalculatorEx

class CalculateBrainMock: ICalculatorBrain {
    var mockResult: Double = 0
    var mocksequenceExpress: String = ""

    func performOperation(_ symbol: String) {
    }
    
    func setOperand(_ operand: Double?) {
    }
    
    func sequenceExpress() -> String {
        mocksequenceExpress
    }
    
    func getPerformResult() -> Double? {
        mockResult
    }
}
