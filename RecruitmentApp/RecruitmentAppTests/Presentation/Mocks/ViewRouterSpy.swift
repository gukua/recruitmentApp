import UIKit
@testable import RecruitmentApp

class ViewRouterSpy: ViewRouter {
    
    var navigateToLogin_called = false
    var navigateToRegister_called = false
    var navigateToHome_called = false
    
    func createRootViewController() -> UIViewController {
        UIViewController()
    }
    
    func navigateToLogin(on: UINavigationController) {
        navigateToLogin_called = true
    }
    
    func navigateToRegister(on: UINavigationController) {
        navigateToRegister_called = true
    }
    
    func navigateToHome() {
        navigateToHome_called = true
    }
}
