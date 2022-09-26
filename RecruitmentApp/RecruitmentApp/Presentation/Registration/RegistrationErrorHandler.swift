//
//  RegistrationErrorHandler.swift
//  RecruitmentApp
//
//  Created by Adrian Krzyżowski on 23/09/2022.
//

protocol RegistrationErrorHandler {
    func handle(error: Error)
}

class RegistrationErrorHandlerImpl: RegistrationErrorHandler {
    let alertPresenter: AlertPresenter

    init(alertPresenter: AlertPresenter) {
        self.alertPresenter = alertPresenter
    }

    func handle(error: Error) {
        alertPresenter.showOk(message: ErrorMsgFactory.msg(for: error))
    }
}
