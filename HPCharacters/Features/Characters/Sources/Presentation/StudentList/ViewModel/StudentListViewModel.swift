import Core
import Combine
import Foundation
import CharactersDomain
import Shared
import NavigationManager

public class StudentListViewModel: BaseViewModel {
    private let usecase: StudentListUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    @Published public var isLoading: Bool = false
    @Published public var errorMessage: String? = nil
    @Published public var students: [StudentDomainModel] = []
    
    public init(usecase: StudentListUseCaseProtocol) {
        self.usecase = usecase
    }
    
    public func onAppear() {
        self.isLoading = true
        self.usecase.fetchStudents()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] result in
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let students):
                    self.students = students
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            })
            .store(in: &self.cancellables)
    }
    
    public func onDisappear() {
        
    }
    
    public func onSelectStudent(id: String) {
        let destination = AnyDestination(module: ModuleIdentifier.characters, screen: CharactersScreenIdentifier.studentDetails(id: id))
        NavigationManager.shared.push(destination: destination)
    }
}
