//
//  RegistrationErrorHandlerSpy.swift
//  RecruitmentAppTests
//
//  Created by Adrian Krzyżowski on 23/09/2022.
//

@testable import RecruitmentApp

class RegistrationErrorHandlerSpy: RegistrationErrorHandler {
    var handle_called = false
    var handle_params_error: Error?

    func handle(error: Error) {
        handle_called = true
        handle_params_error = error
    }
}

