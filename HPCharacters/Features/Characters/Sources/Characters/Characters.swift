import Core
import CharactersMapper
import CharactersData
import CharactersDomain
import CharactersPresentation
import Shared

/// A class representing the Characters module within the application.
/// This class is responsible for registering services related to character functionalities,
/// particularly focusing on the student list feature. It conforms to the `Module` protocol,
/// which requires the implementation of the `registerServices` method.
public class CharactersModule: Module {
    
    /// Initializes a new instance of `CharactersModule`.
    /// This initializer sets up the module without any initial configuration.
    public init () {}
    
    /// Registers services for the Characters module.
    /// This method is responsible for setting up the necessary services and dependencies
    /// related to character functionalities, ensuring they are available for use throughout the application.
    public func registerServices() {
        MapperModule().registerServices()
        
        registerStudentListService()
        registerStudentDetailsService()
    }
}

extension CharactersModule {
    
    /// Registers the student list service.
    /// This private method sets up the service responsible for managing the student list,
    /// including its view model, use case, and repository.
    private func registerStudentListService() {
        DIContainer.container.register(StudentListViewModel.self) { resolver in
            let network = resolver.resolve(NetworkManagerProtocol.self, name: ModuleIdentifier.network)
            let service = GetStudentListService(networkManager: network!)
            let repository = StudentListRepository(service: service)
            let usecase = StudentListUseCase(repository: repository)
            
            return StudentListViewModel(usecase: usecase)
        }
    }
    
    /// Registers the student details service.
    /// This private method sets up the service responsible for managing the student details,
    /// including its view model, use case, and repository.
    private func registerStudentDetailsService() {
        DIContainer.container.register(StudentDetailsViewModel.self) { resolver in
            let network = resolver.resolve(NetworkManagerProtocol.self, name: ModuleIdentifier.network)
            let service = GetStudentDetailsService(networkManager: network!)
            let repository = StudentDetailsRepository(service: service)
            let usecase = StudentDetailsUseCase(repository: repository)
            
            return StudentDetailsViewModel(usecase: usecase)
        }
    }
}
