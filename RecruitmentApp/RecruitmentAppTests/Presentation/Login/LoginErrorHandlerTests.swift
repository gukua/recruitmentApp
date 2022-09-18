import XCTest
@testable import AudiotekaDomain
@testable import RecruitmentApp

final class LoginErrorHandlerTests: XCTestCase {
    
    var sut: LoginErrorHandlerImpl!
    var alertPresenterSpy: AlertPresenterSpy!
    
    override func setUp() {
        super.setUp()
        alertPresenterSpy = AlertPresenterSpy()
        sut = LoginErrorHandlerImpl(alertPresenter: alertPresenterSpy)
    }
    
    override func tearDown() {
        alertPresenterSpy = nil
        sut = nil
        super.tearDown()
    }
    
    func test_show_msg_for_incorrect_data() {
        let error = AuthenticationError()
        
        sut.handle(error: error)
        
        XCTAssertTrue(alertPresenterSpy.showOk_called)
        XCTAssertEqual(alertPresenterSpy.showOk_params_message,
                       "error_authentication_error".localized)
    }

    func test_show_msg_for_connection_error() {
        let error = ConnectionError()
        
        sut.handle(error: error)
        
        XCTAssertTrue(alertPresenterSpy.showOk_called)
        XCTAssertEqual(alertPresenterSpy.showOk_params_message,
                       "error_connection_error".localized)
    }
}
