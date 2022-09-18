import UIKit

class ActivityIndicator {
    
    var activityIndicatorCounter = 0
    
    var blockingIndicator: UIView?
    
    private func create(title: String = "dialog_loading_title".localized) -> UIView {
        let blockingIndicator = UIView(frame: UIScreen.main.bounds)
        blockingIndicator.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        blockingIndicator.layer.zPosition = CGFloat.greatestFiniteMagnitude
        
        let innerView = UIView(frame: CGRect(centerIn: blockingIndicator, size: CGSize(150)))
        innerView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        innerView.cornerRadiusValue = 10
        
        let messageLabel = UILabel(frame: CGRect(x: 10, y: innerView.frame.height - 40, width: innerView.frame.width - 20, height: 20))
        messageLabel.text = title
        messageLabel.font = UIFont.systemFont(ofSize: 15)
        messageLabel.textColor = UIColor.white
        messageLabel.textAlignment = .center
        messageLabel.minimumScaleFactor = 0.5
        messageLabel.adjustsFontSizeToFitWidth = true
        
        let spinerImage = UIImage(named: "player_spinner", in: Bundle(for: type(of: self)), compatibleWith: nil)
        let spinnerView = UIImageView(frame: CGRect(centerIn: innerView, size: CGSize(60)).offsetBy(dx: 0, dy: -20))
        spinnerView.image = spinerImage
        spinnerView.startRotateAnimation()
        
        blockingIndicator.addCentered(subview: innerView, width: 150, height: 150)
        innerView.addSubview(messageLabel)
        innerView.addSubview(spinnerView)
        
        return blockingIndicator
    }
    
    func showBlockingActivityIndicator() {
        blockingIndicator?.removeFromSuperview()
        blockingIndicator = create()
        UIApplication.shared.windows.first?.addFilled(subview: blockingIndicator!)
    }
    
    func showBlockingActivityIndicatorWith(title: String) {
        blockingIndicator?.removeFromSuperview()
        blockingIndicator = create(title: title)
        UIApplication.shared.windows.first?.addFilled(subview: blockingIndicator!)
    }
    
    func closeBlockingActivityIndicator() {
        blockingIndicator?.removeFromSuperview()
    }
}

extension CGRect {
    
    init(centerIn parent: UIView, size: CGSize) {
        let center = parent.center - parent.frame.origin
        self.init(x: center.x - size.width / 2, y: center.y - size.height / 2, width: size.width, height: size.height)
    }
}

extension CGSize {
    
    init(_ size: CGFloat) {
        self.init(width: size, height: size)
    }
}

private func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

private func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}
