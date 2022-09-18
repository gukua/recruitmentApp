import UIKit

@IBDesignable
class FullButton: CustomButton {
    
    var customBackground: UIColor? {
        didSet {
            if customBackground != nil {
                setBackgroundImage(customBackground!.toImage(), for: .normal)
                let disabledColor = AppTheme.ButtonTheme.fullButtonBacktroundDisabled
                setBackgroundImage(disabledColor.toImage(), for: .disabled)
            }
        }
    }
    
    var customTitleColor: UIColor? {
        didSet {
            if customTitleColor != nil {
                setTitleColor(customTitleColor!, for: .normal)
                setTitleColor(AppTheme.ButtonTheme.fullButtonTitleDisabled, for: .disabled)
                titleLabel?.highlightedTextColor = AppTheme.ButtonTheme.fullButtonTitle
            }
        }
    }

    override func customise() {
        super.customise()
        
        let backgroundColor = AppTheme.ButtonTheme.fullButtonBackground
        setBackgroundImage(backgroundColor.toImage(), for: .normal)
        let disabledColor = AppTheme.ButtonTheme.fullButtonBacktroundDisabled
        setBackgroundImage(disabledColor.toImage(), for: .disabled)
        tintColor = AppTheme.ButtonTheme.fullButtonBackground
        setTitleColor(AppTheme.ButtonTheme.fullButtonTitle, for: .normal)
        setTitleColor(AppTheme.ButtonTheme.fullButtonTitleDisabled, for: .disabled)
        titleLabel?.highlightedTextColor = AppTheme.ButtonTheme.fullButtonTitle
        self.layer.cornerRadius = 4.0
        clipsToBounds = true
    }
    
}

private extension UIColor {
    
    func toImage(width: CGFloat = 1, height: CGFloat = 1) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(self.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

