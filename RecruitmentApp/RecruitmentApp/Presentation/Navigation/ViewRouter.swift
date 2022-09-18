import Foundation
import UIKit

protocol ViewRouter {
    
    func createRootViewController() -> UIViewController
    func navigateToLogin(on: UINavigationController)
    func navigateToRegister(on: UINavigationController)
    func navigateToHome()
}

class ViewRouterImpl: ViewRouter {
    
    private let viewControllersFactory: ViewControllerFactory
    
    init(viewControllersFactory: ViewControllerFactory = ViewControllerFactoryImpl()) {
        self.viewControllersFactory = viewControllersFactory
    }
    
    func createRootViewController() -> UIViewController {
        let homeVC = viewControllersFactory.getInitialController(StoryboardNames.home)
        let navigationController = UINavigationController()
        navigationController.viewControllers = [homeVC]
        return navigationController
    }
    
    func navigateToLogin(on: UINavigationController) {
        let loginVC = viewControllersFactory.getInitialController(StoryboardNames.login)
        on.pushViewController(loginVC, animated: true)
    }
    
    func navigateToRegister(on: UINavigationController) {
        // not implemented yet!
    }
    
    func navigateToHome() {
        (UIApplication.shared.windows.first?
            .rootViewController as? UINavigationController)?
            .popToRootViewController(animated: false)
    }
}
