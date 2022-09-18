import Foundation
import UIKit

class BaseUIView: UIView {

    var view: UIView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func bundle() -> Bundle {
        return Bundle(for: type(of: self))
    }

    fileprivate func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
        self.view = bundle().loadNibNamed(nibName(), owner: self, options: nil)?.first as? UIView
        self.view?.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view!)
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view!.leadingAnchor),
            trailingAnchor.constraint(equalTo: view!.trailingAnchor),
            topAnchor.constraint(equalTo: view!.topAnchor),
            bottomAnchor.constraint(equalTo: view!.bottomAnchor)
        ])
        view!.backgroundColor = self.backgroundColor
        onInit()
    }
    
    func nibName() -> String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }

    func onInit() {
        localize()
        accessibility()
        style()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.view?.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
    }

    func removeView() {
        self.removeFromSuperview()
        self.view = nil
    }
    
    func localize() {}
    
    func accessibility() {}
    
    func style() {}
}
