import Foundation
@testable import RecruitmentApp

class LoginErrorHandlerSpy: LoginErrorHandler {
    
    var handle_called = false
    var handle_params_error: Error?
    
    func handle(error: Error) {
        handle_called = true
        handle_params_error = error
    }
}
