import Foundation

class LoginViewModel: ViewModel {

    var login = Observable<String>()
    var password = Observable<String>()
    
    var loadingIndicatorVisible = Observable<Bool>(false)
    var loginError = RawObservable<Error>()
    var loginSuccess = RawObservable<Bool>()
}
