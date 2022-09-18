import Foundation
@testable import RecruitmentApp

class AlertPresenterSpy: AlertPresenter {
    
    var showOk_called = false
    var showOk_params_message: String?
    var showOk_params_action: (() -> Void)?
    
    func showOk(message: String, action: (() -> Void)?) {
        showOk_called = true
        showOk_params_message = message
        showOk_params_action = action
    }
}
