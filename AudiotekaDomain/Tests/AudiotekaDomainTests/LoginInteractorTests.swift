import Foundation
import XCTest
@testable import AudiotekaDomain

final class LoginInteractorTests: XCTestCase {
    var sut: LoginInteractorImpl!
    var commandExecutorMock: CommandExecutorMock!
    
    override func setUp() {
        super.setUp()
        commandExecutorMock = CommandExecutorMock()
        sut = LoginInteractorImpl(commandExecutor: commandExecutorMock)
    }
    
    override func tearDown() {
        commandExecutorMock = nil
        sut = nil
        super.tearDown()
    }
    
    func test_login_send_proper_params() throws {
        _ = try sut.login(username: "jan@kowalski@abc.pl",
                          password: "abc123!@#").data()
        
        XCTAssertTrue(commandExecutorMock.execute_called)
        guard let command = commandExecutorMock.execute_params_command else {
            XCTFail(); return
        }
        XCTAssertEqual(command.toDictionary()["name"], "Login")
        XCTAssertEqual(command.toDictionary()["userName"], "jan@kowalski@abc.pl")
        XCTAssertEqual(command.toDictionary()["password"], "abc123!@#")
    }
    
    func test_login_pass_error_from_command_executor() {
        commandExecutorMock.execute_params_throw_error = SampleError()
        
        do {
            _ = try sut.login(username: "jan@kowalski@abc.pl",
                              password: "abc123!@#").data()
            XCTFail()
        } catch let error {
            XCTAssertTrue(error is SampleError)
        }
    }
}
