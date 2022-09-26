//
//  RegistrationViewModel.swift
//  RecruitmentApp
//
//  Created by Adrian Krzyżowski on 23/09/2022.
//

class RegistrationViewModel: ViewModel {

    var login = Observable<String>()
    var password = Observable<String>()

    var loadingIndicatorVisible = Observable<Bool>(false)
    var registrationError = RawObservable<Error>()
    var registrationSuccess = RawObservable<Bool>()
}
