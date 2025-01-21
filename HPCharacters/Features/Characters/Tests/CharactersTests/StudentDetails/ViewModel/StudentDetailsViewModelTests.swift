import XCTest
import Combine
import Core
import CharactersData
import CharactersDomain
import CharactersPresentation

@testable import Characters

final class StudentDetailsViewModelTests: XCTestCase {
    private var viewModel: StudentDetailsViewModel!
    private var mockUseCase: MockStudentDetailsUseCase!
    private var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        mockUseCase = MockStudentDetailsUseCase()
        viewModel = StudentDetailsViewModel(usecase: mockUseCase)
    }

    override func tearDown() {
        mockUseCase = nil
        viewModel = nil
        cancellables.removeAll()
        super.tearDown()
    }

    func testOnAppear_Success() {
        // Arrange
        let expectedStudent =
            StudentDomainModel(
                id: "9e3f7ce4-b9a7-4244-b709-dae5c1f1d4a8", name: "Harry Potter",
                alternateNames: ["The Boy Who Lived","The Chosen One","Undesirable No. 1","Potty"],
                species: "human", gender: "male", house: "Gryffindor", dateOfBirth: "31-07-1980", yearOfBirth: 1980, wizard: true, ancestry: "half-blood", eyeColour: "green", hairColour: "black", wand: WandDomain(wood: "holly", core: "phoenix tail feather", length: 11), patronus: "stag", hogwartsStudent: true, hogwartsStaff: false, actor: "Daniel Radcliffe", alternateActors: [], alive: true, image: "https://ik.imagekit.io/hpapi/harry.jpg")
        
        mockUseCase.response = .success([expectedStudent])

        let expectation = XCTestExpectation(description: "Fetch student details and update view model")

        // Act
        viewModel.$student
            .dropFirst() // Skip initial value
            .sink { student in
                XCTAssertEqual(student, expectedStudent)
                XCTAssertFalse(self.viewModel.isLoading)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.initialize(id: "1")
        viewModel.onAppear()

        wait(for: [expectation], timeout: 1.0)
    }

    func testOnAppear_Failure() {
        // Arrange
        let expectedError = NetworkError.serverError(statusCode: 0)
        mockUseCase.response = .failure(expectedError)

        let expectation = XCTestExpectation(description: "Handle error on fetch student details")

        // Act
        viewModel.$errorMessage
            .dropFirst() // Skip initial value
            .sink { errorMessage in
                XCTAssertNotNil(errorMessage)
                XCTAssertFalse(self.viewModel.isLoading)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.initialize(id: "1")
        viewModel.onAppear()

        wait(for: [expectation], timeout: 1.0)
    }
}
