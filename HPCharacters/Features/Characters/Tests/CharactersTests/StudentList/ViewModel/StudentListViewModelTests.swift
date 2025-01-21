import XCTest
import Combine
import Core
import CharactersDomain
import CharactersPresentation

@testable import Characters

final class StudentListViewModelTests: XCTestCase {
    private var viewModel: StudentListViewModel!
    private var mockUseCase: MockStudentListUseCase!
    private var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        mockUseCase = MockStudentListUseCase()
        viewModel = StudentListViewModel(usecase: mockUseCase)
    }

    override func tearDown() {
        mockUseCase = nil
        viewModel = nil
        cancellables.removeAll()
        super.tearDown()
    }

    func testOnAppear_Success() {
        // Arrange
        let expectedStudents = [
            StudentDomainModel(
                id: "9e3f7ce4-b9a7-4244-b709-dae5c1f1d4a8", name: "Harry Potter",
                alternateNames: ["The Boy Who Lived","The Chosen One","Undesirable No. 1","Potty"],
                species: "human", gender: "male", house: "Gryffindor", dateOfBirth: "31-07-1980", yearOfBirth: 1980, wizard: true, ancestry: "half-blood", eyeColour: "green", hairColour: "black", wand: WandDomain(wood: "holly", core: "phoenix tail feather", length: 11), patronus: "stag", hogwartsStudent: true, hogwartsStaff: false, actor: "Daniel Radcliffe", alternateActors: [], alive: true, image: "https://ik.imagekit.io/hpapi/harry.jpg")]
        mockUseCase.response = .success(expectedStudents)

        let expectation = XCTestExpectation(description: "Fetch students and update view model")

        // Act
        viewModel.$students
            .dropFirst() // Skip initial value
            .sink { students in
                XCTAssertEqual(students, expectedStudents)
                XCTAssertFalse(self.viewModel.isLoading)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.onAppear()

        wait(for: [expectation], timeout: 1.0)
    }

    func testOnAppear_Failure() {
        // Arrange
        let expectedError = NetworkError.serverError(statusCode: 0)
        mockUseCase.response = .failure(expectedError)

        let expectation = XCTestExpectation(description: "Handle error on fetch students")

        // Act
        viewModel.$errorMessage
            .dropFirst() // Skip initial value
            .sink { errorMessage in
                XCTAssertNotNil(errorMessage)
                XCTAssertFalse(self.viewModel.isLoading)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.onAppear()

        wait(for: [expectation], timeout: 1.0)
    }
}
