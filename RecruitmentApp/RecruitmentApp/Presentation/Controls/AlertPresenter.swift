import UIKit

protocol AlertPresenter {
    func showOk(message: String, action: (() -> Void)?)
}

extension AlertPresenter {
    
    func showOk(message: String) {
        showOk(message: message, action: nil)
    }
}

class AlertPresenterImpl: AlertPresenter {
    
    unowned let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func showOk(message: String, action: (() -> Void)?) {
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "alert_ok".localized,
                                      style: .default, handler: { _ in
            action?()
        }))
        viewController.present(alert, animated: true, completion: nil)
    }
}
