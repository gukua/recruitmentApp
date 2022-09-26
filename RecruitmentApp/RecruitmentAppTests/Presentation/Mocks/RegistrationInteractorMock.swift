//
//  RegistrationInteractorMock.swift
//  RecruitmentAppTests
//
//  Created by Adrian Krzyżowski on 23/09/2022.
//

import AudiotekaDomain
import Combine

class RegistrationInteractorMock: RegistrationInteractor {
    var register_called = false
    var register_params_username: String?
    var register_params_password: String?
    var register_throw_error: Error?

    func register(username: String, password: String) -> AnyPublisher<Void, Error> {
        register_called = true
        register_params_username = username
        register_params_password = password
        if let error = register_throw_error {
            return Fail(error: error).eraseToAnyPublisher()
        }
        return Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

