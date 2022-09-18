import UIKit

extension UIView {
    
    func addCentered(subview: UIView, width: CGFloat, height: CGFloat) {
        subview.frame = .zero
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.clipsToBounds = true
        self.addSubview(subview)
        
        subview.widthAnchor.constraint(equalToConstant: width).isActive = true
        subview.heightAnchor.constraint(equalToConstant: height).isActive = true
        subview.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        subview.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
      
        subview.layoutIfNeeded()
        self.layoutIfNeeded()
    }
}
