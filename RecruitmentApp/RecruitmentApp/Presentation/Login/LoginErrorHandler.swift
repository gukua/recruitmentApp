import Foundation

protocol LoginErrorHandler {
    func handle(error: Error)
}

class LoginErrorHandlerImpl: LoginErrorHandler {
    
    let alertPresenter: AlertPresenter
    
    init(alertPresenter: AlertPresenter) {
        self.alertPresenter = alertPresenter
    }
    
    func handle(error: Error) {
        alertPresenter.showOk(message: ErrorMsgFactory.msg(for: error))
    }
}
