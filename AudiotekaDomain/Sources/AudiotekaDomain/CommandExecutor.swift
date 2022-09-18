import Foundation
import Combine

protocol CommandExecutor {
    func execute(command: ApiCommand) -> AnyPublisher<Void, Error>
}

class CommandExecutorImpl: CommandExecutor {
    
    private let httpClient: HttpClient
    
    init(httpClient: HttpClient = HttpClinetImpl()) {
        self.httpClient = httpClient
    }
    
    func execute(command: ApiCommand) -> AnyPublisher<Void, Error> {
        do {
            try httpClient.callRest(with: command.toDictionary())
            return Just<Void>(())
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch let error {
            return Fail<Void, Error>(error: error)
                .eraseToAnyPublisher()
        }
    }
}
