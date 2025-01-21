import Core
import Combine

public protocol GetStudentListServiceProtocol {
    func fetchStudents() -> AnyPublisher<[StudentModel], NetworkError>
}
