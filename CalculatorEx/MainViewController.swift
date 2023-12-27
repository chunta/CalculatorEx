import UIKit
import SnapKit

class MainViewController: UIViewController {

    private var containerView: UIView!

    private var leftView: UIView!

    private var rightView: UIView!

    private var leftCalculator: CalculatorViewController!

    private var rightCalculator: CalculatorViewController!

    private var leftViewModel: ICalculatorViewModel

    private var rightViewModel: ICalculatorViewModel

    private var seperator: CalculatorSeperatorViewController!

    init(leftViewModel: ICalculatorViewModel = CalculatorViewModel(),
         rightViewModel: ICalculatorViewModel = CalculatorViewModel()) {
        self.leftViewModel = leftViewModel
        self.rightViewModel = rightViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpBaseView()
        setUpContentViews()
        setUpContainViewLayout()
        setUpCalculationViews()
        setUpCalculatorViewsLayout()

        setUpSeperatorEvent()
    }

    // MARK: - View / Layout
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
        leftCalculator = CalculatorViewController(viewModel: leftViewModel)
        containerView.addSubview(leftCalculator.view)
        leftCalculator.view.layer.borderWidth = 1
        leftCalculator.view.layer.borderColor = UIColor.red.cgColor

        seperator = CalculatorSeperatorViewController()
        containerView.addSubview(seperator.view)
        seperator.view.layer.borderWidth = 1
        seperator.view.layer.borderColor = UIColor.yellow.cgColor

        rightCalculator = CalculatorViewController(viewModel: rightViewModel)
        containerView.addSubview(rightCalculator.view)
        rightCalculator.view.layer.borderWidth = 1
        rightCalculator.view.layer.borderColor = UIColor.red.cgColor
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
        seperator.view.isHidden = false
        seperator.view.snp.makeConstraints { make in
            make.width.equalTo(containerView.snp.width).multipliedBy(1.0 / 9.0)
            make.height.equalTo(containerView.snp.height).multipliedBy(0.6)
            make.centerX.equalTo(containerView.snp.centerX)
            make.bottom.equalTo(containerView.snp.bottom)
        }

        leftCalculator.view.snp.remakeConstraints { make in
            make.leading.equalTo(containerView.snp.leading)
            make.trailing.equalTo(seperator.view.snp.leading)
            make.height.equalTo(containerView.snp.height)
            make.centerY.equalTo(containerView.snp.centerY)
            make.leading.equalTo(containerView.snp.leading)
        }

        rightCalculator.view.snp.remakeConstraints { make in
            make.leading.equalTo(seperator.view.snp.trailing)
            make.trailing.equalTo(containerView.snp.trailing)
            make.height.equalTo(containerView.snp.height)
            make.centerY.equalTo(containerView.snp.centerY)
        }
        rightCalculator.view.isHidden = false
    }

    private func setUpPortraitLayout() {
        seperator.view.isHidden = true

        leftCalculator.view.snp.remakeConstraints { make in
            make.width.equalTo(containerView.snp.width)
            make.height.equalTo(containerView.snp.height)
            make.center.equalTo(containerView.snp.center)
        }

        rightCalculator.view.snp.remakeConstraints { make in
            make.width.equalTo(containerView.snp.width)
            make.height.equalTo(containerView.snp.height)
            make.top.equalTo(containerView.snp.bottom)
            make.centerX.equalTo(containerView.snp.centerX)
        }
        rightCalculator.view.isHidden = true
    }

    // MARK: - Event
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        setUpCalculatorViewsLayout()
    }

    private func setUpSeperatorEvent() {
        seperator.delAction = { [weak self] in
            guard let self else { return }
            self.leftViewModel.cleanAllCalculation()
            self.rightViewModel.cleanAllCalculation()
        }
        seperator.leftArrowAction = { [weak self] in
            guard let self else { return }
            if let result = self.rightViewModel.getPerformResult() {
                self.leftViewModel.addAssitantValue("\(result)")
            }
        }
        seperator.rightArrowAction = { [weak self] in
            guard let self else { return }
            if let result = self.leftViewModel.getPerformResult() {
                self.rightViewModel.addAssitantValue("\(result)")
            }
        }
    }
}
