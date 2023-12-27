import UIKit

/// A view controller handling the functionality of a calculator.
class CalculatorViewController: UIViewController {

    // Display Labels
    @IBOutlet private var assistantLabel: UILabel!

    @IBOutlet private var mainDisplayLabel: UILabel!

    @IBOutlet private var sequenceLabel: UILabel!

    // Digit Buttons
    @IBOutlet private var digitButtons: [UIButton]!

    // Operator Buttons
    @IBOutlet private var operatorButtons: [UIButton]!

    private var viewModel: ICalculatorViewModel

    private var userIsInTheMiddleOfTyping = false

    private var displayValue: Double {
        get {
            return Double(mainDisplayLabel.text ?? Constants.emptyString) ?? Double.nan
        }
        set {
            let tmp = String(newValue).removeAfterPointIfZero()
            mainDisplayLabel.text = tmp.setMaxLength(of: Constants.maxResultDisplayLength)
        }
    }

    init(viewModel: ICalculatorViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButtonTitles()
        setUpViewModelEvent()
    }

    // MARK: - Set Up
    private func setUpButtonTitles() {
        setButtonTitles(for: digitButtons,
                        with: [DigitSymbol.Zero.rawValue,
                               DigitSymbol.One.rawValue,
                               DigitSymbol.Two.rawValue,
                               DigitSymbol.Three.rawValue,
                               DigitSymbol.Four.rawValue,
                               DigitSymbol.Five.rawValue,
                               DigitSymbol.Six.rawValue,
                               DigitSymbol.Seven.rawValue,
                               DigitSymbol.Eight.rawValue,
                               DigitSymbol.Nine.rawValue,
                               DigitSymbol.Dot.rawValue])
        setButtonTitles(for: operatorButtons,
                        with: [OperatorSymbol.Multiply.rawValue,
                               OperatorSymbol.Divide.rawValue,
                               OperatorSymbol.Minus.rawValue,
                               OperatorSymbol.Plus.rawValue,
                               OperatorSymbol.Percentage.rawValue,
                               OperatorSymbol.Eqaul.rawValue,
                               OperatorSymbol.Negative.rawValue,
                               OperatorSymbol.AllClean.rawValue])
    }

    private func setButtonTitles(for buttons: [UIButton], with titles: [String]) {
        for (index, button) in buttons.enumerated() {
            button.setTitle(titles[index], for: .normal)
        }
    }

    private func setUpViewModelEvent() {
        viewModel.allCleanCompletionHandler = { [weak self] in
            guard let self else { return }
            self.mainDisplayLabel.text = ""
            self.sequenceLabel.text = ""
            self.assistantLabel.text = ""
        }
        viewModel.assistantCompletionHandler = { [weak self] result in
            self?.assistantLabel.text = result.removeAfterPointIfZero()
        }
    }

    // MARK: - Event
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        view.setNeedsLayout()
    }

    // Digit 0 ~ 9 .
    @IBAction func touchDigit(_ sender: UIButton) {
        guard let digit = sender.currentTitle else { return }
        if userIsInTheMiddleOfTyping {
            guard let textCurrentlyInDisplay = mainDisplayLabel.text else { return }

            if digit == DigitSymbol.Dot.rawValue && (textCurrentlyInDisplay.range(of: Constants.decimalPoint) != nil) {
                return
            } else {
                let tmp = textCurrentlyInDisplay + digit
                mainDisplayLabel.text = tmp.setMaxLength(of: Constants.maxResultDisplayLength)
            }
        } else {
            if digit == Constants.decimalPoint {
                mainDisplayLabel.text = Constants.pointAfterZero
            } else {
                mainDisplayLabel.text = digit
            }
            userIsInTheMiddleOfTyping = true
        }

        sequenceLabel.text = viewModel.sequenceExpress()
    }

    // Operator
    @IBAction func touchOperator(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            viewModel.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }

        if let mathematicalSymbol = sender.currentTitle,
           let symbol = OperatorSymbol(rawValue: mathematicalSymbol) {
            viewModel.performOperation(symbol)
        }

        if let result = viewModel.getPerformResult() {
            displayValue = result
        }
        sequenceLabel.text = viewModel.sequenceExpress()
    }
}
