import XCTest
@testable import CalculatorEx

class CalculatorViewControllerTests: XCTestCase {

    private var viewController: CalculatorViewController!

    private var mockViewModel: CalculateViewModelMock!

    override func setUp() {
        mockViewModel = CalculateViewModelMock()
        viewController = CalculatorViewController(viewModel: mockViewModel)
        viewController.loadViewIfNeeded()
    }

    func testMainDisplayLabelWhenTouchDigit() {
        guard let oneButton = digitButton(DigitSymbol.One) else {
            XCTFail("The '1' digit button should be found")
            return
        }
        oneButton.sendActions(for: .touchUpInside)
        oneButton.sendActions(for: .touchUpInside)
        let mainLabel = mainDisplayLabel()
        let textValue = mainLabel.text ?? ""
        XCTAssertEqual(textValue, "11")
    }

    func testSequenceLabelWhenTocuhDigit() {
        mockViewModel.mocksequenceExpressString = "1+"
        guard let oneButton = digitButton(DigitSymbol.One) else {
            XCTFail("The '1' digit button should be found")
            return
        }
        oneButton.sendActions(for: .touchUpInside)
        let sequenceLabel = sequenceLabel()
        let textValue = sequenceLabel.text ?? ""
        XCTAssertEqual(textValue, mockViewModel.mocksequenceExpressString)
    }

    func testMainDisplayLabelWithResult() {
        mockViewModel.mockResult = 576
        guard let equalButton = operatorButton(OperatorSymbol.Eqaul) else {
            XCTFail("The '=' operand button should be found")
            return
        }
        equalButton.sendActions(for: .touchUpInside)
        let mainLabel = mainDisplayLabel()
        let textValue = mainLabel.text ?? ""
        XCTAssertEqual(textValue, "\(mockViewModel.mockResult)".removeAfterPointIfZero())
    }
    
    func testAssistantLabel() {
        let mockValue = "9012"
        mockViewModel.addAssitantValue(mockValue)
        let assistantLabel = assistantLabel()
        XCTAssertEqual(assistantLabel.text, mockValue)
    }

    func testAllClean() {
        guard let oneButton = digitButton(DigitSymbol.One) else {
            XCTFail("The '1' digit button should be found")
            return
        }
        oneButton.sendActions(for: .touchUpInside)
        mockViewModel.mockResult = 576
        guard let minusButton = operatorButton(OperatorSymbol.Minus) else {
            XCTFail("The '=' operand button should be found")
            return
        }
        minusButton.sendActions(for: .touchUpInside)
        mockViewModel.cleanAllCalculation()

        let mainDisplayLabel = mainDisplayLabel()
        let assistantLabel = assistantLabel()
        let sequenceLabel = sequenceLabel()
        XCTAssertEqual(mainDisplayLabel.text?.count, 0)
        XCTAssertEqual(assistantLabel.text?.count, 0)
        XCTAssertEqual(sequenceLabel.text?.count, 0)
    }
}

extension CalculatorViewControllerTests {

    func mainDisplayLabel() -> UILabel {
        viewController.value(forKey: "mainDisplayLabel") as! UILabel
    }

    func sequenceLabel() -> UILabel {
        viewController.value(forKey: "sequenceLabel") as! UILabel
    }

    func assistantLabel() -> UILabel {
        viewController.value(forKey: "assistantLabel") as! UILabel
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
