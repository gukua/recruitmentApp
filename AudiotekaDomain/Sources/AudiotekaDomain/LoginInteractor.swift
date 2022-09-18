import Foundation
import Combine

public protocol LoginInteractor {
    func login(username: String,
               password: String) -> AnyPublisher<Void, Error>
}

public class LoginInteractorImpl: LoginInteractor {
    
    private let commandExecutor: CommandExecutor
    
    init(commandExecutor: CommandExecutor) {
        self.commandExecutor = commandExecutor
    }
    
    public convenience init() {
        self.init(commandExecutor: CommandExecutorImpl())
    }
    
    public func login(username: String,
                      password: String) -> AnyPublisher<Void, Error> {
        let loginCommand = ApiLoginCommand(login: username, password: password)
        return commandExecutor.execute(command: loginCommand)
    }
}
