import Foundation
import UIKit

extension UITextField {
    
    @IBInspectable var secured: Bool {
        get {
            return rightViewMode == .always && isSecureTextEntry
        } set (enabled) {
            if rightView == nil {
                addButton()
            }
            rightViewMode = enabled ? .always : .never
        }
    }
    
    private func addButton() {
        let height = self.frame.size.height
        let buttonHeight = CGFloat(18)
        let buttonWidth = CGFloat(18)
        let offset = CGFloat(10)
        
        let button = UIButton(frame: CGRect(x: offset, y: offset, width: buttonWidth, height: buttonHeight))
        button.addTarget(self, action: #selector(changeState), for: .touchUpInside)
        let view = UIView(frame: CGRect(x: 0, y: (buttonHeight - height) / 2, width: buttonWidth + offset * 2, height: buttonHeight + offset * 2))
        view.addSubview(button)
        rightView = view
        updateState(button, true)
    }
    
    @objc private func changeState(_ sender: UIButton) {
        updateState(sender, !isSecureTextEntry)
    }
    
    private func updateState(_ button: UIButton!, _ secured: Bool) {
        isSecureTextEntry = secured
        let resId = isSecureTextEntry ? "i_password_hidden" : "i_password_visible"
        button.setImage(UIImage(named: resId)?.withRenderingMode(.alwaysTemplate), for: UIControl.State.normal)
        button.tintColor = AppTheme.ProfileTheme.label
    }
}
