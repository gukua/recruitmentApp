import Foundation

class ApiCommand {
    var name: String
    var params: [String: String]
    
    init(name: String) {
        self.name = name
        params = [:]
    }
}

extension ApiCommand {
    
    func toDictionary() -> [String: String] {
        var dict = [ApiConsts.CommandsParamsName.name: self.name]
        dict.merge(dict: self.params as [String: String])
        return dict
    }
}

private extension Dictionary {
    mutating func merge(dict: [Key: Value]) {
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}
