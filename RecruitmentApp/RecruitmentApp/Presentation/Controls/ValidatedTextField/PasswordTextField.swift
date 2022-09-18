import UIKit

class PasswordTextField: ValidatedTextField {
    
    var lenghtRule: Rule = (expression: "^.{6,}$", message: "too_short_password_message".localized)
    
    override func onInit() {
        super.onInit()
        textField.secured = true
        textField.accessibilityIdentifier = "password_text_field"
        icon.image = UIImage(named: "i_lock")?.withRenderingMode(.alwaysTemplate)
    }
    
    override func localize() {
        textField.placeholder = "authentication_prompt_password".localized
    }
    
    override func validate(_ text: String) -> ValidationResult {
        return validate(rules: [lenghtRule])
    }
    
    override func nibName() -> String {
        return "ValidatedTextField"
    }
}
