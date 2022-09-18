import UIKit

class LoginTextField: ValidatedTextField {
    
    var lenghtRule: Rule = (expression: "^.{5,}$", message: "login_is_too_short_message".localized)
    
    var emailRules: [Rule] = [(expression: ".*@.*", message: "email_should_contain_at_message".localized),
                              (expression: ".*[.].*", message: "email_should_contain_dot_message".localized)]
    
    override func onInit() {
        super.onInit()
        trimmingTextEnabled = true
        textField.keyboardType = .emailAddress
        icon.image = UIImage(named: "i_person")?.withRenderingMode(.alwaysTemplate)
    }
    
    override func validate(_ text: String) -> ValidationResult {
        let lenghtResult = validate(rules: [lenghtRule])
        if !lenghtResult.isValid {
            return lenghtResult
        }
        return validate(rules: emailRules)
    }

    override func localize() {
        textField.placeholder = "authentication_prompt_login".localized
    }
    
    override func nibName() -> String {
        return "ValidatedTextField"
    }
}

extension LoginTextField {

    func disable() {
        textField.isEnabled = false
        icon.tintColor = AppTheme.ButtonTheme.fullButtonTitleDisabled
        textField.backgroundColor = AppTheme.ButtonTheme.fullButtonTitleDisabled.withAlphaComponent(0)
        textField.textColor = AppTheme.ProfileTheme.textFieldTextColor.withAlphaComponent(0.2)
        customBackgroundView.backgroundColor = AppTheme.ButtonTheme.fullButtonTitleDisabled.withAlphaComponent(0.2)
    }

}
