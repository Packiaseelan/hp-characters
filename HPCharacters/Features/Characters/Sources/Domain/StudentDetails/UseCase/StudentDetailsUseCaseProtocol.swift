import Combine
import Core

public protocol StudentDetailsUseCaseProtocol {
    func fetchStudentDetails(id: String) -> Future<Result<[StudentDomainModel], NetworkError>, Never>
}
