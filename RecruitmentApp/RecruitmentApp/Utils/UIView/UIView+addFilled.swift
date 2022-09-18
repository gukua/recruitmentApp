import UIKit

extension UIView {
    func addFilled(subview: UIView, padding: CGFloat = 0) {
        subview.frame = .zero
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.clipsToBounds = true
        
        self.addSubview(subview)
        
        let leadingConstraint = NSLayoutConstraint(item: subview, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: padding)
        let trailingConstraint = NSLayoutConstraint(item: subview, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -padding)
        let bottomConstraint = NSLayoutConstraint(item: subview, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -padding)
        let topConstraint = NSLayoutConstraint(item: subview, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: padding)
        
        self.addConstraint(leadingConstraint)
        self.addConstraint(trailingConstraint)
        self.addConstraint(bottomConstraint)
        self.addConstraint(topConstraint)
        
        subview.layoutIfNeeded()
        self.layoutIfNeeded()
    }
}

