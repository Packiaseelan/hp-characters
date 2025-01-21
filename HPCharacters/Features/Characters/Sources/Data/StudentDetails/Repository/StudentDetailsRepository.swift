import Core
import NetworkManager
import Combine

public class StudentDetailsRepository: StudentDetailsRepositoryProtocol {
    private let service: GetStudentDetailsServiceProtocol
    
    private var cancellables = Set<AnyCancellable>() // To keep track of the subscription
    
    public init(service: GetStudentDetailsServiceProtocol) {
        self.service = service
    }
    
    public func fetchStudentDetails(id: String) -> Future<Result<[StudentModel], NetworkError>, Never> {
        return Future { promise in
            self.service.fetchStudentDetails(id: id)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break // Do nothing, result handled in receiveValue
                    case .failure(let error):
                        promise(.success(.failure(error))) // Return failure result
                    }
                }, receiveValue: { students in
                    promise(.success(.success(students))) // Return success result with students
                })
                .store(in: &self.cancellables)
        }
    }
}
