import Foundation
import AudiotekaDomain
import Combine

class LoginInteractorMock: LoginInteractor {
    
    var login_called = false
    var login_params_username: String?
    var login_params_password: String?
    var login_throw_error: Error?
    
    func login(username: String,
               password: String) -> AnyPublisher<Void, Error> {
        login_called = true
        login_params_username = username
        login_params_password = password
        if let error = login_throw_error {
            return Fail(error: error).eraseToAnyPublisher()
        }
        return Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
