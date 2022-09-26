//
//  RegistrationViewController.swift
//  RecruitmentApp
//
//  Created by Adrian Krzyżowski on 23/09/2022.
//

import UIKit

final class RegistrationViewController: ViewController {
    var viewModel: RegistrationViewModel!
    var presenter: RegistrationPresenter = RegistrationPresenterImpl()
    var viewRouter: ViewRouter = ViewRouterImpl()
    lazy var alertPresenter: AlertPresenter = {
        AlertPresenterImpl(viewController: self)
    }()
    lazy var registrationErrorHandler: RegistrationErrorHandler = {
        RegistrationErrorHandlerImpl(alertPresenter: alertPresenter)
    }()

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
            self?.registerButton.isEnabled = !components.contains(where: { $0 != true })
        }

        viewModel.loadingIndicatorVisible.subscribe { [weak self] value in
            if value! {
                self?.activityIndicator.showBlockingActivityIndicator()
            } else {
                self?.activityIndicator.closeBlockingActivityIndicator()
            }
        }
        viewModel.registrationError.subscribe { [weak self] error in
            if let error = error {
                self?.registrationErrorHandler.handle(error: error)
            }
        }
        viewModel.registrationSuccess.subscribe { [weak self] in
            if $0 == true {
                self?.alertPresenter.showOk(message: "registration_success".localized) {
                    self?.viewRouter.navigateToHome()
                }
            }
        }
        super.viewDidLoad()
    }

    override func localize() {
        super.localize()
        registerInfo.text = "registration_view_move_to_login_label".localized
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

    @IBAction func registrationButtonAction(_ sender: AnyObject) {
        presenter.registrationClicked()
    }

    @IBAction func loginButtonAction(_ sender: Any) {
        if let navigationController = self.navigationController {
            viewRouter.navigateToLogin(on: navigationController)
        }
    }
}

