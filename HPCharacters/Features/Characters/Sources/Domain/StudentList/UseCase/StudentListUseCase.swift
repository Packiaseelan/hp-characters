import CharactersData
import Combine
import Core
import Shared

public class StudentListUseCase: StudentListUseCaseProtocol {
    private let repository: StudentListRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    public init(repository: StudentListRepositoryProtocol) {
        self.repository = repository
    }
    
    public func fetchStudents() -> Future<Result<[StudentDomainModel], NetworkError>, Never> {
        return Future { promise in
            self.repository.fetchStudents()
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
