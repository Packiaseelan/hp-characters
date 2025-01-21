import Combine
import Core
import CharactersDomain

@testable import Characters

final class MockStudentDetailsUseCase: StudentDetailsUseCaseProtocol {
    var response: Result<[StudentDomainModel], NetworkError>?

    func fetchStudentDetails(id: String) -> Future<Result<[StudentDomainModel], NetworkError>, Never> {
        return Future { promise in
            if let response = self.response {
                promise(.success(response))
            } else {
                promise(.success(.failure(.unknownError))) // Default failure
            }
        }
    }
}
