import Combine
import Core
import CharactersData

@testable import Characters

final class MockStudentDetailsRepository: StudentDetailsRepositoryProtocol {
    var response: Result<[StudentModel], NetworkError>?

    func fetchStudentDetails(id: String) -> Future<Result<[StudentModel], NetworkError>, Never> {
        return Future { promise in
            if let response = self.response {
                promise(.success(response))
            } else {
                promise(.success(.failure(.unknownError))) // Default failure
            }
        }
    }
}
