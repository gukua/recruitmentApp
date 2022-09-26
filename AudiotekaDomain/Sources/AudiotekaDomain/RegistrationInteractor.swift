//
//  File.swift
//  
//
//  Created by Adrian Krzyżowski on 23/09/2022.
//

import Combine

public protocol RegistrationInteractor {
    func register(username: String, password: String) -> AnyPublisher<Void, Error>
}

public class RegistrationInteractorImpl: RegistrationInteractor {
    private let commandExecutor: CommandExecutor

    init(commandExecutor: CommandExecutor) {
        self.commandExecutor = commandExecutor
    }

    public convenience init() {
        self.init(commandExecutor: CommandExecutorImpl())
    }

    public func register(username: String, password: String) -> AnyPublisher<Void, Error> {
        let registrationCommand = ApiRegistrationCommand(login: username, password: password)
        return commandExecutor.execute(command: registrationCommand)
    }
}
