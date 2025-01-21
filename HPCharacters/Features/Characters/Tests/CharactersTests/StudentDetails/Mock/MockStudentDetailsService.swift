import Combine
import Core
import CharactersData

@testable import Characters

class MockStudentDetailsService: GetStudentDetailsServiceProtocol {
    var result: Result<[StudentModel], NetworkError>!
    
    func fetchStudentDetails(id: String) -> AnyPublisher<[StudentModel], NetworkError> {
        return result.publisher.eraseToAnyPublisher()
    }
}
