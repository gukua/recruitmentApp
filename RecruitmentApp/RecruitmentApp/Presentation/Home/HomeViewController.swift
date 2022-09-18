import Foundation
import UIKit

class HomeViewController: ViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    lazy var viewRouter: ViewRouter = ViewRouterImpl()
    
    @IBAction func loginButtonAction(_ sender: Any) {
        
        if let navigationController = self.navigationController {
            viewRouter.navigateToLogin(on: navigationController)
        }
    }
    
    override func localize() {
        super.localize()
        loginButton.setTitle("login_btn".localized, for: .normal)
        registerButton.setTitle("register_btn".localized, for: .normal)
    }
    
    override func style() {
        super.style()
        view.backgroundColor = AppTheme.ProfileTheme.background
    }
}
