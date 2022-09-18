import Foundation

class ApiLoginCommand: ApiCommand {
    
    init(login: String, password: String) {
        super.init(name: ApiConsts.Commands.login)
        self.params[ApiConsts.CommandsParamsName.loginUserName] = login
        self.params[ApiConsts.CommandsParamsName.loginPassword] = password
    }
}
