import Core
import Combine

public protocol StudentDetailsRepositoryProtocol {
    func fetchStudentDetails(id: String) -> Future<Result<[StudentModel], NetworkError>, Never>
}
