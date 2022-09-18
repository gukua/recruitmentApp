import Foundation

struct RegisterApiService {
    
    private let userStorage: UserStorage
    
    init(userStorage: UserStorage) {
        self.userStorage = userStorage
    }
    
    func register(model: RegisterRequestModel) -> HttpResponseCode {
        if userStorage.find(login: model.newUserName) != nil {
            return .alreadyExist
        }
        userStorage.add(user: User(login: model.newUserName,
                                   password: model.password))
        return .ok
    }
}
