import UIKit

/// A view controller managing the separator view between two calculators, providing actions for navigation and deletion.
class CalculatorSeperatorViewController: UIViewController {

    var leftArrowAction: (() -> Void)?
    var rightArrowAction: (() -> Void)?
    var delAction: (() -> Void)?

    @IBAction func leftArrowDidTap(_ sender: UIButton) {
        leftArrowAction?()
    }

    @IBAction func rightArrowDidTap(_ sender: UIButton) {
        rightArrowAction?()
    }

    @IBAction func delDidTap(_ sender: UIButton) {
        delAction?()
    }
}
