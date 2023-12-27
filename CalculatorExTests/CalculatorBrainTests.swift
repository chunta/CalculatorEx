import XCTest
@testable import CalculatorEx

final class CalculatorBrainTests: XCTestCase {

    private var brain: CalculatorBrain!

    override func setUp() {
        brain = CalculatorBrain()
    }

    func testPlusOperand() {
        brain.setOperand(1)
        brain.performOperation(OperatorSymbol.Plus.rawValue)
        brain.setOperand(1)
        brain.performOperation(OperatorSymbol.Eqaul.rawValue)
        guard let result = brain.result else {
            XCTFail()
            return
        }
        XCTAssertEqual(result, 2.0)
    }

    func testMinusOperand() {
        brain.setOperand(2)
        brain.performOperation(OperatorSymbol.Minus.rawValue)
        brain.setOperand(1)
        brain.performOperation(OperatorSymbol.Eqaul.rawValue)
        guard let result = brain.result else {
            XCTFail()
            return
        }
        XCTAssertEqual(result, 1.0)
    }

    func testMultiplyOperand() {
        brain.setOperand(12)
        brain.performOperation(OperatorSymbol.Multiply.rawValue)
        brain.setOperand(101)
        brain.performOperation(OperatorSymbol.Eqaul.rawValue)
        guard let result = brain.result else {
            XCTFail()
            return
        }
        XCTAssertEqual(result, 1212.0)
    }

    func testDivideOperand() {
        brain.setOperand(12)
        brain.performOperation(OperatorSymbol.Divide.rawValue)
        brain.setOperand(4)
        brain.performOperation(OperatorSymbol.Eqaul.rawValue)
        guard let result = brain.result else {
            XCTFail()
            return
        }
        XCTAssertEqual(result, 3.0)
    }
}
