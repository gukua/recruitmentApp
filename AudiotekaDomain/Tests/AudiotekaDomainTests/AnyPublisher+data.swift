import Foundation
import Combine

extension AnyPublisher {
    
    func data() throws -> Output {
        var output: Output?
        var error: Error?
        let semaphore = DispatchSemaphore(value: 0)
        var cancellable: AnyCancellable?
        
        cancellable = sink { completition in
            error = completition.error()
            semaphore.signal()
            withExtendedLifetime(cancellable, {})
            cancellable = nil
        } receiveValue: { result in
            output = result
        }
        
        semaphore.wait()
        if error != nil {
            throw error!
        }
        return output!
    }
}

extension Subscribers.Completion {
    func error() -> Error? {
        switch self {
        case .failure(let error):
            return error
        default:
            return nil
        }
    }
}
