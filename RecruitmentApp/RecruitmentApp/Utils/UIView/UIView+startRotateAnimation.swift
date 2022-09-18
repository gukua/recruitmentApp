import UIKit

extension UIView {
    
    func startRotateAnimation() {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float(CGFloat.greatestFiniteMagnitude)
        rotation.isRemovedOnCompletion = false
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func stopRotateAnimation() {
        self.layer.removeAnimation(forKey: "rotationAnimation")
    }
}
