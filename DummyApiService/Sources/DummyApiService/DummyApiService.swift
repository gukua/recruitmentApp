import Foundation
public struct DummyApiService {
    
    private let decoder = JSONDecoder()
    private let loginService: LoginApiService
    private let registerService: RegisterApiService
    
    public init() {
        let userStorage = UserStorage.shared
        loginService = LoginApiService(userStorage: userStorage)
        registerService = RegisterApiService(userStorage: userStorage)
    }
    
    public func callMethodWith(jsonData: String) -> HttpResponseCode {
        sleep(5) //it is for simulate network connection only,
        //these are not the droids you're looking for :)
        
        if Int.random(in: 0...10) < 3 {
            return .connectionError
        }
        
        guard let data = jsonData.data(using: .utf8) else {
            return .requestError
        }
        do {
            return try callMethod(with: data)
        } catch {
            return .internalServerError
        }
    }
    
    private func callMethod(with data: Data) throws -> HttpResponseCode {
        let method = try decoder.decode(MethodName.self, from: data)
        switch method.name {
        case "Login":
            let loginModel = try decoder.decode(LoginRequestModel.self, from: data)
            return loginService.login(model: loginModel)
        case "Register":
            let registerModel = try decoder.decode(RegisterRequestModel.self, from: data)
            return registerService.register(model: registerModel)
        default:
            return .requestError
        }
    }
}
