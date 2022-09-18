import Foundation

infix operator =~

func =~ (string: String?, regex: String) -> Bool {
    return string?.range(of: regex, options: .regularExpression) != nil
}

extension String {
    
    func search(regex: String) -> String? {
        guard let range = range(of: regex, options: .regularExpression) else {
            return nil
        }
        return String(self[range])
    }
}
