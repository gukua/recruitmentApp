//
//  RegistrationPresenterTests.swift
//  RecruitmentAppTests
//
//  Created by Adrian Krzyżowski on 23/09/2022.
//

import XCTest
@testable import RecruitmentApp

final class RegistrationPresenterTests: XCTestCase {
    var sut: RegistrationPresenterImpl!
    var registrationInteractorMock: RegistrationInteractorMock!
    var registrationPresenterMock: RegistrationPresenterMock!

    override func setUp() {
        super.setUp()
        registrationInteractorMock = RegistrationInteractorMock()
        sut = RegistrationPresenterImpl(registrationInteractor: registrationInteractorMock)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_registration_click_calls_registration_interactor() {
        sut.viewModel.login.value = "awdaw@wp.pl"
        sut.viewModel.password.value = "1234567"
        let expectation = expectation(description: "registrationTests")

        sut.registrationClicked()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 0.5)
        XCTAssertTrue(registrationInteractorMock.register_called)
        XCTAssertEqual(registrationInteractorMock.register_params_username, "awdaw@wp.pl")
        XCTAssertEqual(registrationInteractorMock.register_params_password, "1234567")
    }

    func test_registration_click_not_call_registration_interactor() {
        sut.registrationClicked()

        XCTAssertFalse(registrationInteractorMock.register_called)
    }

    func test_on_registration_success_pass_info_to_view_model() {
        sut.viewModel.login.value = "awdaw@wp.pl"
        sut.viewModel.password.value = "1234567"
        let expectation = expectation(description: "registrationTests")

        sut.registrationClicked()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 0.5)
        XCTAssertTrue(sut.viewModel.registrationSuccess.value ?? false)
    }

    func test_on_registration_fail_pass_info_to_view_model() {
        sut.viewModel.login.value = "awdaw@wp.pl"
        sut.viewModel.password.value = "1234567"
        let error = SampleError()
        registrationInteractorMock.register_throw_error = error
        let expectation = expectation(description: "registrationTests")

        sut.registrationClicked()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 0.5)
        XCTAssertFalse(sut.viewModel.registrationSuccess.value ?? false)
        XCTAssertTrue(sut.viewModel.registrationError.value is SampleError)
    }
}
