//
//  RegistrationViewControllerTests.swift
//  RecruitmentAppTests
//
//  Created by Adrian Krzyżowski on 23/09/2022.
//

import XCTest
@testable import RecruitmentApp

final class RegistrationViewControllerTests: XCTestCase {
    var sut: RegistrationViewController!
    var viewRouterSpy: ViewRouterSpy!
    var registrationErrorHandlerSpy: RegistrationErrorHandlerSpy!
    var presenterMock: RegistrationPresenterMock!
    var alertPresenterSpy: AlertPresenterSpy!

    override func setUp() {
        super.setUp()
        viewRouterSpy = ViewRouterSpy()
        registrationErrorHandlerSpy = RegistrationErrorHandlerSpy()
        presenterMock = RegistrationPresenterMock()
        alertPresenterSpy = AlertPresenterSpy()

        sut = createSut()
        sut.viewRouter = viewRouterSpy
        sut.registrationErrorHandler = registrationErrorHandlerSpy
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

    private func fillRegistrationData() {
        _ = sut.view
        sut.loginField.textField.text = "asdb@wp.pl"
        sut.loginField.textField.sendActions(for: .valueChanged)
        sut.passwordField.textField.text = "1234567"
        sut.passwordField.textField.sendActions(for: .valueChanged)
    }


    func test_login_button_active() {
        _ = sut.view

        XCTAssertTrue(sut.loginButton.isEnabled)
    }

    func test_registration_button_inactive() {
        _ = sut.view

        XCTAssertFalse(sut.registerButton.isEnabled)
    }

    func test_registration_button_active() {
        fillRegistrationData()

        XCTAssertTrue(sut.registerButton.isEnabled)
    }

    func test_registration_button_call_presenter() {
        fillRegistrationData()

        sut.registerButton.sendActions(for: .touchUpInside)

        XCTAssertTrue(presenterMock.registrationClicked_called)
    }

    func test_registration_success_show_info_alert() {
        _ = sut.view

        sut.viewModel.registrationSuccess.value = true

        XCTAssertTrue(alertPresenterSpy.showOk_called)
        XCTAssertEqual(alertPresenterSpy.showOk_params_message, "registration_success".localized)
    }

    func test_navigate_to_home_after_registration_success() {
        _ = sut.view

        sut.viewModel.registrationSuccess.value = true
        alertPresenterSpy.showOk_params_action?()

        XCTAssertTrue(viewRouterSpy.navigateToHome_called)
    }

    func test_registration_error_call_error_handler() {
        _ = sut.view

        sut.viewModel.registrationError.value = SampleError()

        XCTAssertTrue(registrationErrorHandlerSpy.handle_called)
        XCTAssertTrue(registrationErrorHandlerSpy.handle_params_error is SampleError)
    }
}

extension RegistrationViewControllerTests {
    func createSut() -> RegistrationViewController {
        ViewControllerFactoryImpl().getInitialController(StoryboardNames.registration) as! RegistrationViewController
    }
}

