import Foundation

struct LoginApiService {
    
    private let userStorage: UserStorage
    
    init(userStorage: UserStorage) {
        self.userStorage = userStorage
    }
    
    func login(model: LoginRequestModel) -> HttpResponseCode {
        if let user = userStorage.find(login: model.userName) {
            if user.password == model.password {
                return .ok
            }
        }
        return .authenticationError
    }
}
