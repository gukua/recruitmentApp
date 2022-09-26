//
//  File.swift
//  
//
//  Created by Adrian Krzyżowski on 23/09/2022.
//

import XCTest
@testable import AudiotekaDomain

final class RegistrationInteractorTests: XCTestCase {
    var sut: RegistrationInteractorImpl!
    var commandExecutorMock: CommandExecutorMock!

    override func setUp() {
        super.setUp()
        commandExecutorMock = CommandExecutorMock()
        sut = RegistrationInteractorImpl(commandExecutor: commandExecutorMock)
    }

    override func tearDown() {
        commandExecutorMock = nil
        sut = nil
        super.tearDown()
    }

    func test_register_send_proper_params() throws {
        _ = try sut.register(username: "akrzyzowski@abc.pl", password: "1234567").data()

        XCTAssertTrue(commandExecutorMock.execute_called)
        guard let command = commandExecutorMock.execute_params_command else {
            XCTFail()
            return
        }
        XCTAssertEqual(command.toDictionary()["name"], "Register")
        XCTAssertEqual(command.toDictionary()["newUserName"], "akrzyzowski@abc.pl")
        XCTAssertEqual(command.toDictionary()["password"], "1234567")
    }

    func test_login_pass_error_from_command_executor() {
        commandExecutorMock.execute_params_throw_error = SampleError()

        do {
            _ = try sut.register(username: "akrzyzowski@abc.pl", password: "1234567").data()
            XCTFail()
        } catch let error {
            XCTAssertTrue(error is SampleError)
        }
    }
}

