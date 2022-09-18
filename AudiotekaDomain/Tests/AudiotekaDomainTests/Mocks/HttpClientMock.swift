import Foundation
@testable import AudiotekaDomain

class HttpClientMock: HttpClient {
    
    var callRest_called = false
    var callRest_params: [String: String]?
    var callRest_throw_error: Error?
    
    func callRest(with: [String : String]) throws {
        callRest_called = true
        callRest_params = with
        if let callRestThrowError = callRest_throw_error {
            throw callRestThrowError
        }
    }
}
