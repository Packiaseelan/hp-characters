import Combine
import Core
import CharactersData

@testable import Characters

class MockStudentListService: GetStudentListServiceProtocol {
    var result: Result<[StudentModel], NetworkError>?
    
    func fetchStudents() -> AnyPublisher<[StudentModel], NetworkError> {
        guard let result = result else {
            return Fail(error: NetworkError.unknownError).eraseToAnyPublisher()
        }
        return result.publisher.eraseToAnyPublisher()
    }
}
