import UIKit
import Foundation

class ValidatedTextField: BaseUIView, UITextFieldDelegate {
    
    typealias Rule = (expression: String, message: String)
    var inputValid = Observable<Bool>(false)
    var trimmingTextEnabled = false
    private var validationTextEnabled = false
    @IBOutlet var customBackgroundView: UIView!
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var label: UILabel!
    @IBOutlet var icon: UIImageView!
    @IBOutlet var iconWidthConstraint: NSLayoutConstraint!
    
    var iconVisibility: Bool = true {
        didSet {
            icon.isHidden = !iconVisibility
            if iconVisibility {
                iconWidthConstraint.constant = 28
            } else {
                iconWidthConstraint.constant = 0
            }
        }
    }
    
    override func onInit() {
        super.onInit()
        textField.font = UIFont.systemFont(ofSize: 16) //uzycie wiekszego rozmiaru czcionki, powoduje ze kursor nie przesuwa tekstu przy koncu textfield'a
        self.textField.accessibilityTraits = UIAccessibilityTraits.allowsDirectInteraction
        textField.autocorrectionType = .no
        textField.delegate = self
        textField.addTarget(self, action: #selector(onTextChanged), for: .allEvents)
    }
    
    @objc private func onTextChanged(textField: UITextField) {
        let text = textField.text ?? ""
        let result = self.validate(text)
        inputValid.value = result.isValid
        label.text = (!result.isValid && validationTextEnabled) ? result.message : nil
        if trimmingTextEnabled {
            textField.text = text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    func validate(_ text: String) -> ValidationResult {
         preconditionFailure("This method must be overridden")
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        validationTextEnabled = true
        onTextChanged(textField: textField)
        return true
    }
    
    override func nibName() -> String {
        return "ValidatedTextField"
    }
    
    func enableValidationDuringTextChanged() {
        self.validationTextEnabled = true
    }
    
    func validate(rules: [Rule]) -> ValidationResult {
        for rule in rules where !(textField.text =~ rule.expression) {
            return ValidationResult(isValid: false, message: rule.message)
        }
        return ValidationResult(isValid: true, message: nil)
    }
    
    override func style() {
        super.style()
        icon.tintColor = AppTheme.ProfileTheme.textFieldTintColor
        textField.backgroundColor = AppTheme.ProfileTheme.textFieldBackgroundColor
        textField.textColor = AppTheme.ProfileTheme.textFieldTextColor
        textField.tintColor = AppTheme.ProfileTheme.textFieldTintColor
        textField.placeholderColor = AppTheme.ProfileTheme.textFieldTintColor
        customBackgroundView.backgroundColor = AppTheme.ProfileTheme.textFieldBackgroundColor
        customBackgroundView.layer.cornerRadius = 8
    }
}

struct ValidationResult {
    var isValid: Bool
    var message: String?
}

extension UITextField {
    @IBInspectable var placeholderColor: UIColor {
        get {
            return attributedPlaceholder?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor ?? .clear
        }
        set {
            guard let attributedPlaceholder = attributedPlaceholder else { return }
            let attributes: [NSAttributedString.Key: UIColor] = [.foregroundColor: newValue]
            self.attributedPlaceholder = NSAttributedString(string: attributedPlaceholder.string, attributes: attributes)
        }
    }
}
