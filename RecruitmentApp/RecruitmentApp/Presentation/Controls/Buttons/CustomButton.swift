import UIKit

class CustomButton: UIButton {
    
    private let activityIndicatorTag = 3252
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customise()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customise()
    }
    
    func customise() {
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title?.uppercased(), for: state)
    }
}
