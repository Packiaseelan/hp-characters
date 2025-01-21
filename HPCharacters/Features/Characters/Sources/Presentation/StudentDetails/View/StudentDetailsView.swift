
import SwiftUI
import Core
import CharactersUiKit

public struct StudentDetailsView: BaseView {
    @StateObject public var viewModel: StudentDetailsViewModel
    
    public init(viewModel: StudentDetailsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                if let student = viewModel.student {
                    StudentDetails(attributes: StudentDetailsAttributes(
                        image: student.image, name: student.name, actor: student.actor,
                        species: student.species, gender: student.gender, house: student.house, dateOfBirth: student.dateOfBirth, wizard: student.wizard,ancestry: student.ancestry, eyeColour: student.eyeColour, hairColour: student.hairColour, patronus: student.patronus, alternateActors: student.alternateNames, alive: student.alive, onBack: viewModel.onback
                    ))
                }
            }
        }
        .background(BackgroundImage())
        .onAppear(perform: viewModel.onAppear)
        .onDisappear(perform: viewModel.onDisappear)
    }
}
