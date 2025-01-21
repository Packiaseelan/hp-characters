import Core
import Combine

public protocol StudentListRepositoryProtocol {
    func fetchStudents() -> Future<Result<[StudentModel], NetworkError>, Never>
}
