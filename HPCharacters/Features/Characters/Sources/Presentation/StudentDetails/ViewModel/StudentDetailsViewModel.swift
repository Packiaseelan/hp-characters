
import Core
import Foundation
import CharactersDomain
import NavigationManager
import Combine

public class StudentDetailsViewModel: BaseViewModel {
    private let usecase: StudentDetailsUseCaseProtocol
    private var studentId: String = ""
    private var cancellables = Set<AnyCancellable>()
    
    @Published public var isLoading: Bool = false
    @Published public var errorMessage: String? = nil
    @Published public var student: StudentDomainModel? = nil
    
    public init(usecase: StudentDetailsUseCaseProtocol) {
        self.usecase = usecase
    }
    
    public func initialize(id: String) {
        self.studentId = id
    }
    
    public func onAppear() {
        self.isLoading = true
        self.usecase.fetchStudentDetails(id: studentId)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] result in
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let students):
                    self.student = students.first
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            })
            .store(in: &self.cancellables)
    }
    
    public func onDisappear() { }
    
    public func onback() {
        NavigationManager.shared.pop()
    }
}
