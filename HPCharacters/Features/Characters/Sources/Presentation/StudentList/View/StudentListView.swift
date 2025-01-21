import SwiftUI
import Core
import CharactersUiKit

public struct StudentListView: BaseView {
    @StateObject public var viewModel: StudentListViewModel
    
    public init(viewModel: StudentListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack {
            LogoImage()
            
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVGrid(
                        columns: [GridItem(.fixed(180)), GridItem(.fixed(180))],
                        spacing: 16
                    ) {
                        ForEach(viewModel.students) { student in
                            ProfileCard(
                                attributes: ProfileAttributes(
                                    image: student.image,
                                    name: student.name,
                                    actor: student.actor
                                )
                            )
                            .onTapGesture {
                                viewModel.onSelectStudent(id: student.id)
                            }
                        }
                    }
                }
                
            }
        }
        .background(BackgroundImage())
        .padding(.horizontal)
        .onAppear(perform: viewModel.onAppear)
        .onDisappear(perform: viewModel.onDisappear)
    }
}
