import Core
import Combine

public class GetStudentDetailsService: GetStudentDetailsServiceProtocol {
    private let networkManager: NetworkManagerProtocol

    public init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    public func fetchStudentDetails(id: String) -> AnyPublisher<[StudentModel], NetworkError> {
        let request = NetworkRequest(path: "character/\(id)", method: .get)
        return networkManager.request(with: request)
    }
}
