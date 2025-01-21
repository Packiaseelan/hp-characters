import Core
import Combine

public protocol GetStudentDetailsServiceProtocol {
    func fetchStudentDetails(id: String) -> AnyPublisher<[StudentModel], NetworkError>
}
