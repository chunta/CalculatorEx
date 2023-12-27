import UIKit

/// A custom subclass of UIButton providing a stylized calculator button appearance.
class CalculatorButton: UIButton {

    /// The corner radius of the button.
    @IBInspectable var cornerRadius: CGFloat = 8.0

    /// The color used to fill the button.
    @IBInspectable var drawColor: UIColor = UIColor.black

    /// The image displayed in the button for the normal state.
    @IBInspectable var imageNormal: UIImage?

    /// The insets for the button's content.
    private var insets: UIEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)

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
