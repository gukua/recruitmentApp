import UIKit

@IBDesignable
class EmptyButton: CustomButton {
    
    @IBInspectable var hasBorder: Bool = false {
        didSet {
            layer.borderWidth = hasBorder ? 1 : 0.0
        }
    }
    
    var mainColor: UIColor = AppTheme.tintColor {
        didSet {
            customise()
        }
    }
    
    override func customise() {
        super.customise()
        tintColor = mainColor
        setTitleColor(mainColor, for: .normal)
        titleLabel?.highlightedTextColor = mainColor
        layer.borderColor = mainColor.cgColor
        layer.borderWidth = hasBorder ? 1 : 0.0
        layer.cornerRadius = 4
        contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        layer.borderColor = mainColor.cgColor
    }
    
    override var isHighlighted: Bool {
        didSet {
            let fadedColor = mainColor.withAlphaComponent(0.2).cgColor
            if isHighlighted {
                layer.borderColor = fadedColor
            } else {
                layer.borderColor = mainColor.cgColor
                let animation = CABasicAnimation(keyPath: "borderColor")
                animation.fromValue = fadedColor
                animation.toValue = mainColor.cgColor
                animation.duration = 0.4
                layer.add(animation, forKey: "")
            }
        }
    }
}
