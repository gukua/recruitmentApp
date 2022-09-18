import Foundation
@testable import RecruitmentApp

class LoginPresenterMock: LoginPresenter {
    
    let viewModel: LoginViewModel = LoginViewModel()
    
    var loginClicked_called = false
    func loginClicked() {
        loginClicked_called = true
    }
}
