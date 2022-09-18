import UIKit

private let darkViolet = UIColor(r: 22, g: 8, b: 41)
private let lightViolet = UIColor(r: 56, g: 0, b: 137)
private let lightenViolet = UIColor(r: 86, g: 30, b: 167)
private let violetTint = UIColor(r: 141, g: 136, b: 158)
private let gridViolet = UIColor(r: 36, g: 23, b: 63)
private let selectedGridViolet = UIColor(r: 32, g: 13, b: 58)

class FlavorTheme {
    static let accent = UIColor(r: 77, g: 255, b: 197)
    static let navigationBar = darkViolet
    static let navigationBarTint = UIColor.white
    static let windowBackground = darkViolet
    static let secondaryWindowBackground = darkViolet
    static let emptyListIconTint = violetTint
    static let tabBarBackground = lightViolet
    static let tabBarIconTintActive = UIColor.white
    static let tabBarIconTintInactive = UIColor.white.withAlphaComponent(0.5)
    static let showcaseAndRecommendedAfterAndHighlight = lightViolet
    static let textColor = UIColor.white
    static let lightTextColor = violetTint
    static let cellBackground = gridViolet
    static let playerBackground = UIColor(r: 40, g: 16, b: 73)
    static let attachmentProgressColor = UIColor(r: 214, g: 25, b: 255)
    static let inboxEpirationInfo = UIColor.white
    static let listCornerRadiusValue: CGFloat = 1
    static let productCardButtonBackground: UIColor = UIColor.white
    static let productCardButtonText: UIColor = lightViolet
    static let stickyPlayerPlayIconTint: UIColor = UIColor.white
    static let baseButtonTitle: UIColor = lightViolet
    static let subscriptionHighlight: UIColor = showcaseAndRecommendedAfterAndHighlight
    static let ratingTint: UIColor = lightViolet
    static let switchOnColor = accent
    static let errorColor: UIColor = .red
}

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255,
                  green: g/255,
                  blue: b/255,
                  alpha: 1)
    }
}
