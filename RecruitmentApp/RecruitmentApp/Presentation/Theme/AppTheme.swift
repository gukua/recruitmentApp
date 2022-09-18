import UIKit

struct AppTheme {
    
    static let tintColor = FlavorTheme.accent
    
    class ProfileTheme {
        static let info: UIColor = FlavorTheme.lightTextColor
        static let label: UIColor = FlavorTheme.lightTextColor
        static let separator: UIColor = UIColor(white: 3/255, alpha: 1)
        static let background: UIColor = FlavorTheme.windowBackground
        static let textFieldTextColor = FlavorTheme.textColor
        static let textFieldBackgroundColor = FlavorTheme.cellBackground
        static let textFieldBackgroundColorDisabled = FlavorTheme.lightTextColor
        static let textFieldTintColor = FlavorTheme.lightTextColor
        static let sessionExpiredBackground = UIColor(red: 251 / 255, green: 59 / 255, blue: 8 / 255, alpha: 1)
    }
    
    struct ButtonTheme {
        static let emptyButtonTint = FlavorTheme.accent
        static let fullButtonBacktroundDisabled = FlavorTheme.emptyListIconTint.withAlphaComponent(0.2)
        static let fullButtonTitleDisabled = FlavorTheme.emptyListIconTint.withAlphaComponent(0.5)
        static let fullButtonTint = FlavorTheme.accent
        static let fullButtonTitle = FlavorTheme.baseButtonTitle
        static let fullButtonBackground = FlavorTheme.accent
        
        static let textButtonTitle = FlavorTheme.accent
    }
}
