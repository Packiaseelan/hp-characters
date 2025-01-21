import Core
import SwiftUI
import Shared
import CharactersPresentation

public final class CharactersNavigationManager: @preconcurrency ModuleNavigationManagerProtocol {

    public init() {}

    public func navigate(to destination: CharactersScreenIdentifier) { }

    @MainActor
    public func view(for destination: CharactersScreenIdentifier, arguments: [String: AnyHashable]) -> AnyView {
        switch destination {
        case .studentList:
            let viewModel = DIContainer.container.resolve(StudentListViewModel.self)!
            return AnyView(StudentListView(viewModel: viewModel))
            
        case .studentDetails(let id):
            let viewModel = DIContainer.container.resolve(StudentDetailsViewModel.self)!
            viewModel.initialize(id: id)
            return AnyView(StudentDetailsView(viewModel: viewModel))
        }
    }
}
