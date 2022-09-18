import Foundation

class UserStorage {
    
    private var users: [User]
    
    init() {
        users = []
        add(user: User(login: "admin@abc.info", password: "123456"))
    }
    
    func add(user: User) {
        users.append(user)
    }
    
    func find(login: String) -> User? {
        return users.first(where: { $0.login == login })
    }
}

struct User {
    let login: String
    let password: String
}
