import Foundation
import DummyApiService

protocol HttpClient {
    func callRest(with: [String: String]) throws
}

class HttpClinetImpl: HttpClient {
    
    private let dummyApiService = DummyApiService()
    
    func callRest(with: [String: String]) throws {
        let jsonEncoder = JSONEncoder()
        let data = try jsonEncoder.encode(with)
        guard let jsonString = String(data: data, encoding: .utf8) else {
            throw RequestError()
        }
        let response = dummyApiService.callMethodWith(jsonData: jsonString)
        if let error = response.toError() {
            throw error
        }
    }
}

private extension HttpResponseCode {
    func toError() -> Error? {
        switch self {
        case .requestError:
            return RequestError()
        case .authenticationError:
            return AuthenticationError()
        case .internalServerError:
            return InternalServerError()
        case .connectionError:
            return ConnectionError()
        case .ok:
            return nil
        case .alreadyExist:
            return nil
        }
    }
}
