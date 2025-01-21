import XCTest
import Combine
import Core
import CharactersData

@testable import Characters

final class StudentListRepositoryTests: XCTestCase {
    private var repository: StudentListRepository!
    private var mockService: MockStudentListService!
    private var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        mockService = MockStudentListService()
        repository = StudentListRepository(service: mockService)
    }

    override func tearDown() {
        mockService = nil
        repository = nil
        cancellables.removeAll()
        super.tearDown()
    }

    func testFetchStudents_Success() {
        // Arrange
        let expectedStudents = [
            StudentModel(
                id: "9e3f7ce4-b9a7-4244-b709-dae5c1f1d4a8", name: "Harry Potter",
                alternateNames: ["The Boy Who Lived","The Chosen One","Undesirable No. 1","Potty"],
                species: "human", gender: "male", house: "Gryffindor", dateOfBirth: "31-07-1980", yearOfBirth: 1980, wizard: true, ancestry: "half-blood", eyeColour: "green", hairColour: "black", wand: Wand(wood: "holly", core: "phoenix tail feather", length: 11), patronus: "stag", hogwartsStudent: true, hogwartsStaff: false, actor: "Daniel Radcliffe", alternateActors: [], alive: true, image: "https://ik.imagekit.io/hpapi/harry.jpg")]
        
        mockService.result = .success(expectedStudents)

        let expectation = XCTestExpectation(description: "Fetch students success")

        // Act
        repository.fetchStudents()
            .sink { result in
                if case .success(let students) = result {
                    XCTAssertEqual(students, expectedStudents)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchStudents_Failure() {
        // Arrange
        let expectedError = NetworkError.serverError(statusCode: 0)
        mockService.result = .failure(expectedError)

        let expectation = XCTestExpectation(description: "Fetch students failure")

        // Act
        repository.fetchStudents()
            .sink { result in
                if case .failure(let error) = result {
                    XCTAssertEqual(error, expectedError)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}
