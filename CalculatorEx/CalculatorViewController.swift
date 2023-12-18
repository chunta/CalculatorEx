import UIKit

/// A view controller handling the functionality of a calculator.
class CalculatorViewController: UIViewController {

    // Display Labels
    @IBOutlet private var assistantLabel: UILabel!

    @IBOutlet private var mainDisplayLabel: UILabel!

    @IBOutlet private var inputSequenceLabel: UILabel!
    
    // Digit Buttons
    @IBOutlet private var zeroButton: UIButton!

    @IBOutlet private var oneButton: UIButton!

    @IBOutlet private var twoButton: UIButton!

    @IBOutlet private var threeButton: UIButton!

    @IBOutlet private var fourButton: UIButton!

    @IBOutlet private var fiveButton: UIButton!

    @IBOutlet private var sixButton: UIButton!

    @IBOutlet private var sevenButton: UIButton!

    @IBOutlet private var eightButton: UIButton!

    @IBOutlet private var nineButton: UIButton!

    @IBOutlet private var dotButton: UIButton!

    // Operator Buttons
    @IBOutlet private var multiplyButton: UIButton!

    @IBOutlet private var divideButton: UIButton!

    @IBOutlet private var minusButton: UIButton!

    @IBOutlet private var plusButton: UIButton!

    @IBOutlet private var percentageButton: UIButton!

    @IBOutlet private var equalButton: UIButton!

    @IBOutlet private var negativeButton: UIButton!

    @IBOutlet private var allCleanButton: UIButton!

    private var viewModel: ICalculatorViewModel

    private var userIsInTheMiddleOfTyping = false

    private var displayValue: Double {
        get {
            return Double(mainDisplayLabel.text ?? Constants.emptyString) ?? Double.nan
        }
        set {
            let tmp = String(newValue).removeAfterPointIfZero()
            mainDisplayLabel.text = tmp.setMaxLength(of: 8)
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
        setUpDigitButtonTitles()
        setUpOperatorButtonTitles()
    }

    // MARK: - Set Up
    private func setUpDigitButtonTitles() {
        zeroButton.setTitle(DigitList.Zero.rawValue, for: .normal)
        oneButton.setTitle(DigitList.One.rawValue, for: .normal)
        twoButton.setTitle(DigitList.Two.rawValue, for: .normal)
        threeButton.setTitle(DigitList.Three.rawValue, for: .normal)
        fourButton.setTitle(DigitList.Four.rawValue, for: .normal)
        fiveButton.setTitle(DigitList.Five.rawValue, for: .normal)
        sixButton.setTitle(DigitList.Six.rawValue, for: .normal)
        sevenButton.setTitle(DigitList.Seven.rawValue, for: .normal)
        eightButton.setTitle(DigitList.Eight.rawValue, for: .normal)
        nineButton.setTitle(DigitList.Nine.rawValue, for: .normal)
        dotButton.setTitle(DigitList.Dot.rawValue, for: .normal)
    }

    private func setUpOperatorButtonTitles() {
        multiplyButton.setTitle(OperationList.Multiply.rawValue, for: .normal)
        divideButton.setTitle(OperationList.Divide.rawValue, for: .normal)
        minusButton.setTitle(OperationList.Minus.rawValue, for: .normal)
        plusButton.setTitle(OperationList.Plus.rawValue, for: .normal)
        percentageButton.setTitle(OperationList.Percentage.rawValue, for: .normal)
        equalButton.setTitle(OperationList.Eqaul.rawValue, for: .normal)
        negativeButton.setTitle(OperationList.Negative.rawValue, for: .normal)
        allCleanButton.setTitle(OperationList.AllClean.rawValue, for: .normal)
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

            if digit == DigitList.Dot.rawValue && (textCurrentlyInDisplay.range(of: Constants.decimalPoint) != nil) {
                return
            } else {
                let tmp = textCurrentlyInDisplay + digit
                mainDisplayLabel.text = tmp.setMaxLength(of: Constants.maxStringLength)
            }
        } else {
            if digit == Constants.decimalPoint {
                mainDisplayLabel.text = Constants.pointAfterZero
            } else {
                mainDisplayLabel.text = digit
            }
            userIsInTheMiddleOfTyping = true
        }

        inputSequenceLabel.text = viewModel.sequenceExpress()
    }

    // Operator
    @IBAction func touchOperator(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            print("setOperan \(displayValue)")
            viewModel.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }

        if let mathematicalSymbol = sender.currentTitle {
            print("perform operation \(mathematicalSymbol)")
            viewModel.performOperation(mathematicalSymbol)
        }

        if let result = viewModel.getPerformResult() {
            displayValue = result
        }

        inputSequenceLabel.text = viewModel.sequenceExpress()
    }
}
