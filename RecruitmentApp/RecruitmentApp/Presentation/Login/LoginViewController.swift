import Foundation
import UIKit

class LoginViewController: ViewController {
    
    var viewModel: LoginViewModel!
    var presenter: LoginPresenter = LoginPresenterImpl()
    
    lazy var alertPresenter: AlertPresenter = {
        AlertPresenterImpl(viewController: self)
    }()
    
    lazy var loginErrorHandler: LoginErrorHandler = {
        LoginErrorHandlerImpl(alertPresenter: alertPresenter)
    }()
    var viewRouter: ViewRouter = ViewRouterImpl()
    
    private let activityIndicator = ActivityIndicator()
    
    @IBOutlet var loginField: LoginTextField!
    @IBOutlet var passwordField: PasswordTextField!
    @IBOutlet var loginButton: FullButton!
    @IBOutlet var registerInfo: UILabel!
    @IBOutlet var registerButton: FullButton!
    
    override func viewDidLoad() {
        viewModel = presenter.viewModel
        viewModel.login.bidirectionalBind(to: loginField.textField)
        viewModel.password.bidirectionalBind(to: passwordField.textField)
        
        [loginField.inputValid, passwordField.inputValid].subscribe { [weak self] components in
            self?.loginButton.isEnabled = !components.contains(where: { $0 != true })
        }
        
        viewModel.loadingIndicatorVisible.subscribe { [weak self] value in
            if value! {
                self?.activityIndicator.showBlockingActivityIndicator()
            } else {
                self?.activityIndicator.closeBlockingActivityIndicator()
            }
        }
        
        viewModel.loginError.subscribe { [weak self] error in
            if let error = error {
                self?.loginErrorHandler.handle(error: error)
            }
        }
        
        viewModel.loginSuccess.subscribe { [weak self] in
            if $0 == true {
                self?.alertPresenter.showOk(message: "login_success".localized) {
                    self?.viewRouter.navigateToHome()
                }
            }
        }
        
        super.viewDidLoad()
    }
    
    override func localize() {
        super.localize()
        
        registerInfo.text = "login_view_move_to_register_label".localized
        loginButton.setTitle("login_btn".localized, for: .normal)

        registerButton.setTitle("register_btn".localized, for: .normal)
    }
    
    override func style() {
        super.style()
        self.registerInfo.textColor = AppTheme.ProfileTheme.label
        self.view.backgroundColor = AppTheme.ProfileTheme.background
        
        loginField.icon.tintColor = AppTheme.ProfileTheme.label
        passwordField.icon.tintColor = AppTheme.ProfileTheme.label
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    @IBAction func loginButtonAction(_ sender: AnyObject) {
        presenter.loginClicked()
    }
}
