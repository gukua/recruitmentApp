//
//  RegistrationErrorHandlerTests.swift
//  RecruitmentAppTests
//
//  Created by Adrian Krzyżowski on 23/09/2022.
//

import XCTest
@testable import AudiotekaDomain
@testable import RecruitmentApp

final class RegistrationErrorHandlerTests: XCTestCase {
    var sut: RegistrationErrorHandlerImpl!
    var alertPresenterSpy: AlertPresenterSpy!

    override func setUp() {
        super.setUp()
        alertPresenterSpy = AlertPresenterSpy()
        sut = RegistrationErrorHandlerImpl(alertPresenter: alertPresenterSpy)
    }

    override func tearDown() {
        alertPresenterSpy = nil
        sut = nil
        super.tearDown()
    }

    func test_show_msg_for_account_already_exists() {
        let error = AlreadyExistsError()

        sut.handle(error: error)

        XCTAssertTrue(alertPresenterSpy.showOk_called)
        XCTAssertEqual(alertPresenterSpy.showOk_params_message, "error_account_exists".localized)
    }

    func test_show_msg_for_connection_error() {
        let error = ConnectionError()

        sut.handle(error: error)

        XCTAssertTrue(alertPresenterSpy.showOk_called)
        XCTAssertEqual(alertPresenterSpy.showOk_params_message, "error_connection_error".localized)
    }
}

