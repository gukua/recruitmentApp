import Foundation
import AudiotekaDomain

struct ErrorMsgFactory {
    
    static func msg(for error: Error) -> String {
        switch error {
        case is AuthenticationError:
            return "error_authentication_error".localized
        case is RequestError:
            return "error_request_error".localized
        case is InternalServerError:
            return "error_internal_server_error".localized
        case is ConnectionError:
            return "error_connection_error".localized
        case is AlreadyExistsError:
            return "error_account_exists".localized
        default:
            return error.localizedDescription;
        }
    }
}
