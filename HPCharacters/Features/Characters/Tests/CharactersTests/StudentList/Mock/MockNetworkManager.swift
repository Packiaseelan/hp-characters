import Combine
import Core
import CharactersData

@testable import Characters

final class MockNetworkManager: NetworkManagerProtocol {
    var response: Result<[StudentModel], NetworkError>?

    func request<T>(with request: NetworkRequest) -> AnyPublisher<T, NetworkError> where T: Decodable {
        return Future<T, NetworkError> { promise in
            guard let response = self.response else {
                promise(.failure(.unknownError)) // Default failure if response isn't set
                return
            }
            
            switch response {
            case .success(let students):
                if let castedStudents = students as? T {
                    promise(.success(castedStudents))
                } else {
                    promise(.failure(.decodingFailed)) // Handle casting error
                }
            case .failure(let error):
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}
