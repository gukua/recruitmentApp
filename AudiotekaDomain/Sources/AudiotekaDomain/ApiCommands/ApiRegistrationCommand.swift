//
//  File.swift
//  
//
//  Created by Adrian Krzyżowski on 23/09/2022.
//

class ApiRegistrationCommand: ApiCommand {
    init(login: String, password: String) {
        super.init(name: ApiConsts.Commands.registration)
        self.params[ApiConsts.CommandsParamsName.newUserName] = login
        self.params[ApiConsts.CommandsParamsName.password] = password
    }
}

