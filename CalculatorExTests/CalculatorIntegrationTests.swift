import XCTest
@testable import CalculatorEx

class CalculatorIntegrationTests: XCTestCase {

    private var viewController: CalculatorViewController!

    override func setUp() {
        viewController = CalculatorViewController(viewModel: CalculatorViewModel())
        viewController.loadViewIfNeeded()
    }

    // Test expression: 11 + 1 = 12
    func testOneOnePlusOneExpress() {
        guard let oneButton = digitButton(DigitSymbol.One) else {
            XCTFail("The '1' digit button should be found")
            return
        }
        oneButton.sendActions(for: .touchUpInside)
        oneButton.sendActions(for: .touchUpInside)

        guard let plusButton = operatorButton(OperatorSymbol.Plus) else {
            XCTFail("The '+' operator button should be found")
            return
        }
        plusButton.sendActions(for: .touchUpInside)

        oneButton.sendActions(for: .touchUpInside)

        guard let equalButton = operatorButton(OperatorSymbol.Eqaul) else {
            XCTFail("The '=' operator button should be found")
            return
        }
        equalButton.sendActions(for: .touchUpInside)

        let mainLabel = mainDisplayLabel()
        let textValue = mainLabel.text ?? ""
        XCTAssertEqual(textValue, "12")
    }

    // Test expression: 0.01 * 100 - (-9) = 10
    func testPercentageMultiplyAndNegative() {
        // 1
        guard let oneButton = digitButton(DigitSymbol.One) else {
            XCTFail("The '1' digit button should be found")
            return
        }
        oneButton.sendActions(for: .touchUpInside)

        // 0.01
        guard let percentageButton = operatorButton(OperatorSymbol.Percentage) else {
            XCTFail("The '%' operator button should be found")
            return
        }
        percentageButton.sendActions(for: .touchUpInside)

        // X
        guard let multipluButton = operatorButton(OperatorSymbol.Multiply) else {
            XCTFail("The '%' operator button should be found")
            return
        }
        multipluButton.sendActions(for: .touchUpInside)

        // 100
        oneButton.sendActions(for: .touchUpInside)
        guard let zeroButton = digitButton(DigitSymbol.Zero) else {
            XCTFail("The '0' digit button should be found")
            return
        }
        zeroButton.sendActions(for: .touchUpInside)
        zeroButton.sendActions(for: .touchUpInside)

        // -
        guard let minusButton = operatorButton(OperatorSymbol.Minus) else {
            XCTFail("The '%' operator button should be found")
            return
        }
        minusButton.sendActions(for: .touchUpInside)

        // -9
        guard let nineButton = digitButton(DigitSymbol.Nine) else {
            XCTFail("The '1' digit button should be found")
            return
        }
        nineButton.sendActions(for: .touchUpInside)

        guard let negativeButton = operatorButton(OperatorSymbol.Negative) else {
            XCTFail("The '%' operator button should be found")
            return
        }
        negativeButton.sendActions(for: .touchUpInside)

        // =
        guard let equalButton = operatorButton(OperatorSymbol.Eqaul) else {
            XCTFail("The '=' operator button should be found")
            return
        }
        equalButton.sendActions(for: .touchUpInside)

        let mainLabel = mainDisplayLabel()
        let textValue = mainLabel.text ?? ""
        XCTAssertEqual(textValue, "10")
    }
    
    func mainDisplayLabel() -> UILabel {
        viewController.value(forKey: "mainDisplayLabel") as! UILabel
    }

    func digitButton(_ symbol: DigitSymbol) -> UIButton? {
        guard let digitButtons = viewController.value(forKey: "digitButtons") as? [UIButton] else {
            return nil
        }
        if let button = digitButtons.first(where: { $0.titleLabel?.text == symbol.rawValue }) {
            return button
        }
        return nil
    }

    func operatorButton(_ symbol: OperatorSymbol) -> UIButton? {
        guard let operatorButtons = viewController.value(forKey: "operatorButtons") as? [UIButton] else {
            return nil
        }
        if let button = operatorButtons.first(where: { $0.titleLabel?.text == symbol.rawValue }) {
            return button
        }
        return nil
    }
}
