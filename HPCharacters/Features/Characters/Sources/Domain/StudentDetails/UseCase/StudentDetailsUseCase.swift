import CharactersData
import Combine
import Core
import Shared

public class StudentDetailsUseCase: StudentDetailsUseCaseProtocol {
    private let repository: StudentDetailsRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    public init(repository: StudentDetailsRepositoryProtocol) {
        self.repository = repository
    }
    
    public func fetchStudentDetails(id: String) -> Future<Result<[StudentDomainModel], NetworkError>, Never> {
        return Future { promise in
            self.repository.fetchStudentDetails(id: id)
                .map { stm in
                    stm.map { students in
                        let mapper = self.getMapper()
                        return students.map {
                            mapper.fromDataModelToDomainModel(data: $0) as! StudentDomainModel
                        }
                    }
                }
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break // No action needed on successful completion
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }, receiveValue: { studentModels in
                    promise(.success(studentModels))
                })
                .store(in: &self.cancellables)
        }
    }
    
    private func getMapper() -> BaseDomainMapper {
        let mapper = DIContainer.container.resolve(BaseDomainMapper.self, name: CharactersMapperIdentifier.studentList)!
        return mapper
    }
}
