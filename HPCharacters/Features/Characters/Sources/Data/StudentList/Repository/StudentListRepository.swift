import Core
import Combine

public class StudentListRepository: StudentListRepositoryProtocol {
    private let service: GetStudentListServiceProtocol
    
    private var cancellables = Set<AnyCancellable>() // To keep track of the subscription
    
    public init(service: GetStudentListServiceProtocol) {
        self.service = service
    }
    
    public func fetchStudents() -> Future<Result<[StudentModel], NetworkError>, Never> {
        return Future { promise in
            self.service.fetchStudents()
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
