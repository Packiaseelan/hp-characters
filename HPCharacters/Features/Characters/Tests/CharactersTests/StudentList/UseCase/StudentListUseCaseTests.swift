import XCTest
import Combine
import Core
import Shared
import CharactersData
import CharactersDomain
import CharactersMapper

@testable import Characters

final class StudentListUseCaseTests: XCTestCase {
    private var useCase: StudentListUseCase!
    private var mockRepository: MockStudentListRepository!
    private var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        mockRepository = MockStudentListRepository()
        useCase = StudentListUseCase(repository: mockRepository)
        
        DIContainer.container.register(
            BaseDomainMapper.self,
            name: CharactersMapperIdentifier.studentList,
            factory: { _ in StudentDomainMapper() }
        )
    }

    override func tearDown() {
        mockRepository = nil
        useCase = nil
        cancellables.removeAll()
        super.tearDown()
    }

    func testFetchStudents_Success() {
        // Arrange
        let expectedDataModels = [StudentModel(id: "9e3f7ce4-b9a7-4244-b709-dae5c1f1d4a8", name: "Harry Potter",
                                               alternateNames: ["The Boy Who Lived","The Chosen One","Undesirable No. 1","Potty"],
                                               species: "human", gender: "male", house: "Gryffindor", dateOfBirth: "31-07-1980", yearOfBirth: 1980, wizard: true, ancestry: "half-blood", eyeColour: "green", hairColour: "black", wand: Wand(wood: "holly", core: "phoenix tail feather", length: 11), patronus: "stag", hogwartsStudent: true, hogwartsStaff: false, actor: "Daniel Radcliffe", alternateActors: [], alive: true, image: "https://ik.imagekit.io/hpapi/harry.jpg")]
        
        
        let expectedStudentsDmain = [
            StudentDomainModel(
                id: "9e3f7ce4-b9a7-4244-b709-dae5c1f1d4a8", name: "Harry Potter",
                alternateNames: ["The Boy Who Lived","The Chosen One","Undesirable No. 1","Potty"],
                species: "human", gender: "male", house: "Gryffindor", dateOfBirth: "31-07-1980", yearOfBirth: 1980, wizard: true, ancestry: "half-blood", eyeColour: "green", hairColour: "black", wand: WandDomain(wood: "holly", core: "phoenix tail feather", length: 11), patronus: "stag", hogwartsStudent: true, hogwartsStaff: false, actor: "Daniel Radcliffe", alternateActors: [], alive: true, image: "https://ik.imagekit.io/hpapi/harry.jpg")]
        
        mockRepository.response = .success(expectedDataModels)
        
        let expectation = XCTestExpectation(description: "Fetch students success")
        
        // Act
        useCase.fetchStudents()
            .sink { result in
                if case .success(let students) = result {
                    XCTAssertEqual(students, expectedStudentsDmain)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchStudents_Failure() {
        // Arrange
        let expectedError = NetworkError.serverError(statusCode: 0)
        mockRepository.response = .failure(expectedError)

        let expectation = XCTestExpectation(description: "Fetch students failure")

        // Act
        useCase.fetchStudents()
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
