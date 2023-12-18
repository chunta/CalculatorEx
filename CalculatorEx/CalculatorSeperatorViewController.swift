import UIKit

class CalculatorSeperatorViewController: UIViewController {

    var leftArrowAction: (() -> Void)?
    var rightArrowAction: (() -> Void)?
    var delAction: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

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
