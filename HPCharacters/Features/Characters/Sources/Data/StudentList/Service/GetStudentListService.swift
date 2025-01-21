import Core
import Combine

public class GetStudentListService: GetStudentListServiceProtocol {
    private let networkManager: NetworkManagerProtocol

    public init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    public func fetchStudents() -> AnyPublisher<[StudentModel], NetworkError> {
        let request = NetworkRequest(path: "characters/students", method: .get)
        return networkManager.request(with: request)
    }
}
