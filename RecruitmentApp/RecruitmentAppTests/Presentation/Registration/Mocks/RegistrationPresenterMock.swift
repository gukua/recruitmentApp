//
//  RegistrationPresenterMock.swift
//  RecruitmentAppTests
//
//  Created by Adrian Krzyżowski on 23/09/2022.
//

@testable import RecruitmentApp

class RegistrationPresenterMock: RegistrationPresenter {
    let viewModel = RegistrationViewModel()
    var registrationClicked_called = false

    func registrationClicked() {
        registrationClicked_called = true
    }
}
