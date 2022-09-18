import Combine

extension Publisher {
    func onCompletition(receiveCompletion: @escaping (Failure?) -> Void) -> AnyCancellable {
        return sink(receiveCompletion: { result in
            switch result {
            case .failure(let error):
                receiveCompletion(error)
            case .finished:
                receiveCompletion(nil)
            }
        }, receiveValue: { _ in })
    }
}
