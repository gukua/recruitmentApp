import XCTest
@testable import RecruitmentApp

final class LoginPresenterTests: XCTestCase {
    
    var sut: LoginPresenterImpl!
    var loginInteractorMock: LoginInteractorMock!
    var loginPresenterMock: LoginPresenterMock!
    
    override func setUp() {
        super.setUp()
        loginInteractorMock = LoginInteractorMock()
        sut = LoginPresenterImpl(loginInteractor: loginInteractorMock)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_login_click_calls_login_interactor() {
        sut.viewModel.login.value = "abccc"
        sut.viewModel.password.value = "defff"
        let expectation = expectation(description: "loginTests")
        
        sut.loginClicked()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 0.5)
        XCTAssertTrue(loginInteractorMock.login_called)
        XCTAssertEqual(loginInteractorMock.login_params_username, "abccc")
        XCTAssertEqual(loginInteractorMock.login_params_password, "defff")
    }
    
    func test_login_click_not_call_login_interactor() {
        sut.loginClicked()
        
        XCTAssertFalse(loginInteractorMock.login_called)
    }
    
    func test_on_login_success_pass_info_to_view_model() {
        sut.viewModel.login.value = "abccc"
        sut.viewModel.password.value = "defff"
        let expectation = expectation(description: "loginTests")
        
        sut.loginClicked()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 0.5)
        XCTAssertTrue(sut.viewModel.loginSuccess.value ?? false)
    }
    
    func test_on_login_fail_pass_info_to_view_model() {
        sut.viewModel.login.value = "abccc"
        sut.viewModel.password.value = "defff"
        let error = SampleError()
        loginInteractorMock.login_throw_error = error
        let expectation = expectation(description: "loginTests")
        
        sut.loginClicked()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 0.5)
        XCTAssertFalse(sut.viewModel.loginSuccess.value ?? false)
        XCTAssertTrue(sut.viewModel.loginError.value is SampleError)
    }
}
