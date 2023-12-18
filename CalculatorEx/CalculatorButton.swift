import UIKit

class CalculatorButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 8.0

    @IBInspectable var drawColor: UIColor = UIColor.black

    @IBInspectable var imageNormal: UIImage?

    private var insets: UIEdgeInsets = UIEdgeInsets(top: 4,
                                                    left: 4,
                                                    bottom: 4,
                                                    right: 4)
    override func layoutSubviews() {
        super.layoutSubviews()
        if let image = imageNormal {
            setImage(image, for: .normal)
            if frame.size.width > frame.size.height {
                let dif = (frame.size.width - frame.size.height) * 0.5
                imageEdgeInsets = UIEdgeInsets(top: 0, left: dif, bottom: 0, right: dif)
            }
        }
    }

    override func draw(_ rect: CGRect) {
        let innerRect = rect.inset(by: insets)
        let path = UIBezierPath(roundedRect: innerRect, cornerRadius: cornerRadius)
        drawColor.setFill()
        path.fill()
    }
}
