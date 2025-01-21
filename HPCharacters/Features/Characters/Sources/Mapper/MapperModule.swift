import Core
import Shared
import Foundation

public class MapperModule: Module {
    public init() {}
    
    public func registerServices() {
        registerStudentMapperService()
    }
}

extension MapperModule {
    private func registerStudentMapperService() {
        DIContainer.container.register(
            BaseDomainMapper.self,
            name: CharactersMapperIdentifier.studentList,
            factory: { _ in StudentDomainMapper() }
        )
    }
}
