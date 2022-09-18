import Foundation
@testable import AudiotekaDomain
import Combine

class CommandExecutorMock: CommandExecutor {
    
    var execute_called = false
    var execute_params_command: ApiCommand?
    var execute_params_throw_error: Error?
    
    func execute(command: ApiCommand) -> AnyPublisher<Void, Error> {
        execute_called = true
        execute_params_command = command
        if let error = execute_params_throw_error {
            return Fail(error: error).eraseToAnyPublisher()
        }
        return Just<Void>(()).setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
