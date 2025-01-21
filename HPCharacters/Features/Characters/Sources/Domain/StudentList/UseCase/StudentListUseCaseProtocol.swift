import Combine
import Core

public protocol StudentListUseCaseProtocol {
    func fetchStudents() -> Future<Result<[StudentDomainModel], NetworkError>, Never>
}
