import UIKit
import SnapKit

class ViewController: UIViewController {

    private var containerView: UIView!

    private var leftView: UIView!

    private var rightView: UIView!

    private var calculatorLeft: CalculatorViewController!

    private var calculatorRight: CalculatorViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpBaseView()
        setUpContentViews()
        setUpContainViewLayout()
        setUpCalculationViews()
        setUpCalculatorViewsLayout()
    }

    private func setUpBaseView() {
        view.backgroundColor = .black
    }

    private func setUpContentViews() {
        containerView = UIView()
        containerView.backgroundColor = .black
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.orange.cgColor
        view.addSubview(containerView)
    }

    private func setUpContainViewLayout() {
        containerView.snp.remakeConstraints { make in
            make.left.equalTo(view.snp.leftMargin)
            make.right.equalTo(view.snp.rightMargin)
            make.top.equalTo(view.snp.topMargin)
            make.bottom.equalTo(view.snp.bottomMargin)
        }
    }

    private func setUpCalculationViews() {
        calculatorLeft = CalculatorViewController()
        containerView.addSubview(calculatorLeft.view)
        calculatorLeft.view.layer.borderWidth = 1
        calculatorLeft.view.layer.borderColor = UIColor.red.cgColor

        calculatorRight = CalculatorViewController()
        containerView.addSubview(calculatorRight.view)
        calculatorRight.view.layer.borderWidth = 1
        calculatorRight.view.layer.borderColor = UIColor.red.cgColor
    }

    private func setUpCalculatorViewsLayout() {
        if isLandscape() {
            setUpLandscapeLayout()
        } else {
            setUpPortraitLayout()
        }
    }

    private func isLandscape() -> Bool {
        return UIScreen.main.bounds.width > UIScreen.main.bounds.height
    }

    private func setUpLandscapeLayout() {
        calculatorLeft.view.snp.remakeConstraints { make in
            make.width.equalTo(containerView.snp.width).multipliedBy(0.5)
            make.height.equalTo(containerView.snp.height)
            make.centerY.equalTo(containerView.snp.centerY)
            make.leading.equalTo(containerView.snp.leading)
        }
        calculatorRight.view.snp.remakeConstraints { make in
            make.width.equalTo(containerView.snp.width).multipliedBy(0.5)
            make.height.equalTo(containerView.snp.height)
            make.centerY.equalTo(containerView.snp.centerY)
            make.trailing.equalTo(containerView.snp.trailing)
        }
        calculatorRight.view.isHidden = false
    }

    private func setUpPortraitLayout() {
        calculatorLeft.view.snp.remakeConstraints { make in
            make.width.equalTo(containerView.snp.width)
            make.height.equalTo(containerView.snp.height)
            make.center.equalTo(containerView.snp.center)
        }
        calculatorRight.view.snp.remakeConstraints { make in
            make.width.equalTo(containerView.snp.width)
            make.height.equalTo(containerView.snp.height)
            make.top.equalTo(containerView.snp.bottom)
            make.centerX.equalTo(containerView.snp.centerX)
        }
        calculatorRight.view.isHidden = true
    }

    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        setUpCalculatorViewsLayout()
    }
}
