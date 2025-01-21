import Combine
import Core
import CharactersDomain

@testable import Characters

final class MockStudentListUseCase: StudentListUseCaseProtocol {
    var response: Result<[StudentDomainModel], NetworkError>?

    func fetchStudents() -> Future<Result<[StudentDomainModel], NetworkError>, Never> {
        return Future { promise in
            if let response = self.response {
                promise(.success(response))
            } else {
                promise(.success(.failure(.unknownError))) // Default failure
            }
        }
    }
}
