import Foundation
import AudiotekaDomain
import Combine

protocol LoginPresenter: Presenter {
    var viewModel: LoginViewModel { get }
    func loginClicked()
}

class LoginPresenterImpl: LoginPresenter {
    
    let viewModel: LoginViewModel = LoginViewModel()
    private let loginInteractor: LoginInteractor
    private var loginCancellable: AnyCancellable?
    
    init(loginInteractor: LoginInteractor = LoginInteractorImpl()) {
        self.loginInteractor = loginInteractor
    }
    
    func loginClicked() {
        guard let login = viewModel.login.value,
              let password = viewModel.password.value else {
            return
        }
        viewModel.loadingIndicatorVisible.value = true
        loginCancellable?.cancel()
        loginCancellable = loginInteractor.login(username: login,
                              password: password).onCompletition { [unowned self] error in
            viewModel.loadingIndicatorVisible.value = false
            if error != nil {
                viewModel.loginError.value = error
            } else {
                viewModel.loginSuccess.value = true
            }
        }
    }
}
