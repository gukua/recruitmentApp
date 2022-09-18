import XCTest
@testable import RecruitmentApp

final class LoginViewControllerTests: XCTestCase {
    
    var sut: LoginViewController!
    var viewRouterSpy: ViewRouterSpy!
    var loginErrorHandlerSpy: LoginErrorHandlerSpy!
    var presenterMock: LoginPresenterMock!
    var alertPresenterSpy: AlertPresenterSpy!
    
    override func setUp() {
        super.setUp()
        viewRouterSpy = ViewRouterSpy()
        loginErrorHandlerSpy = LoginErrorHandlerSpy()
        presenterMock = LoginPresenterMock()
        alertPresenterSpy = AlertPresenterSpy()
        
        sut = createSut()
        sut.viewRouter = viewRouterSpy
        sut.loginErrorHandler = loginErrorHandlerSpy
        sut.presenter = presenterMock
        sut.alertPresenter = alertPresenterSpy
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_deallocation() {
        weak var weakSut = sut
        autoreleasepool {
            _ = sut.view
        }
            
        sut = nil
        
        XCTAssertNil(weakSut)
    }
    
    private func fillLoginData() {
        _ = sut.view
        sut.loginField.textField.text = "abc@abc.info"
        sut.loginField.textField.sendActions(for: .valueChanged)
        sut.passwordField.textField.text = "pass@ord"
        sut.passwordField.textField.sendActions(for: .valueChanged)
    }
    
    
    func test_login_button_active() {
        fillLoginData()
        
        XCTAssertTrue(sut.loginButton.isEnabled)
        
    }
    
    func test_login_button_inactive() {
        _ = sut.view
        
        XCTAssertFalse(sut.loginButton.isEnabled)
    }
    
    func test_login_button_call_presenter() {
        fillLoginData()
        
        sut.loginButton.sendActions(for: .touchUpInside)
        
        XCTAssertTrue(presenterMock.loginClicked_called)
    }
    
    func test_login_success_show_info_alert() {
        _ = sut.view
        
        sut.viewModel.loginSuccess.value = true
        
        XCTAssertTrue(alertPresenterSpy.showOk_called)
        XCTAssertEqual(alertPresenterSpy.showOk_params_message, "login_success".localized)
    }
    
    func test_navigate_to_home_after_logun_success() {
        _ = sut.view
        
        sut.viewModel.loginSuccess.value = true
        alertPresenterSpy.showOk_params_action?()
        
        XCTAssertTrue(viewRouterSpy.navigateToHome_called)
    }
    
    func test_login_error_call_error_handler() {
        _ = sut.view
        
        sut.viewModel.loginError.value = SampleError()
        
        XCTAssertTrue(loginErrorHandlerSpy.handle_called)
        XCTAssertTrue(loginErrorHandlerSpy.handle_params_error is SampleError)
    }
}

extension LoginViewControllerTests {
    
    func createSut() -> LoginViewController {
        ViewControllerFactoryImpl().getInitialController(StoryboardNames.login) as! LoginViewController
    }
}
