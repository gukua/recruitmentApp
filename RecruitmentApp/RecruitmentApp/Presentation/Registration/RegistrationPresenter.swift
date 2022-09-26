//
//  RegistrationPresenter.swift
//  RecruitmentApp
//
//  Created by Adrian Krzyżowski on 23/09/2022.
//

import Foundation
import AudiotekaDomain
import Combine

protocol RegistrationPresenter: Presenter {
    var viewModel: RegistrationViewModel { get }
    func registrationClicked()
}

class RegistrationPresenterImpl: RegistrationPresenter {
    let viewModel = RegistrationViewModel()
    private let registrationInteractor: RegistrationInteractor
    private var registrationCancellable: AnyCancellable?

    init(registrationInteractor: RegistrationInteractor = RegistrationInteractorImpl()) {
        self.registrationInteractor = registrationInteractor
    }

    func registrationClicked() {
        guard let login = viewModel.login.value, let password = viewModel.password.value else { return }
        viewModel.loadingIndicatorVisible.value = true
        registrationCancellable?.cancel()
        DispatchQueue.global(qos: .userInitiated).async {
            self.registrationCancellable = self.registrationInteractor.register(username: login, password: password)
            .receive(on: DispatchQueue.main)
            .onCompletition { [unowned self] error in
                viewModel.loadingIndicatorVisible.value = false
                if error != nil {
                    viewModel.registrationError.value = error
                } else {
                    viewModel.registrationSuccess.value = true
                }
            }
        }
    }
}
