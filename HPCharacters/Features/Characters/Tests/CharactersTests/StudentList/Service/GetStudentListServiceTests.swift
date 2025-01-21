import XCTest
import Combine
import Core
import CharactersData

@testable import Characters

class GetStudentListServiceTests: XCTestCase {
    private var service: GetStudentListService!
    private var mockNetworkManager: MockNetworkManager!
    private var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        service = GetStudentListService(networkManager: mockNetworkManager)
    }
    
    override func tearDown() {
        mockNetworkManager = nil
        service = nil
        cancellables.removeAll()
        super.tearDown()
    }
    
    func testFetchStudents_Success() {
        // Arrange
        let expectedStudents = [
            StudentModel(
                id: "123",
                name: "John Doe",
                alternateNames: [],
                species: "human",
                gender: "male",
                house: "Gryffindor",
                dateOfBirth: "01-01-2000",
                yearOfBirth: 2000,
                wizard: true,
                ancestry: "pure-blood",
                eyeColour: "blue",
                hairColour: "blonde",
                wand: Wand(wood: "oak", core: "dragon heartstring", length: 12),
                patronus: "lion",
                hogwartsStudent: true,
                hogwartsStaff: false,
                actor: "Actor Name",
                alternateActors: [],
                alive: true,
                image: "https://example.com/john.jpg"
            )
        ]
        mockNetworkManager.response = .success(expectedStudents)
        
        let expectation = self.expectation(description: "Fetch students succeeds")
        
        // Act
        service.fetchStudents()
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        XCTFail("Expected success but got failure: \(error)")
                    }
                },
                receiveValue: { students in
                    // Assert
                    XCTAssertEqual(students, expectedStudents)
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchStudents_Failure() {
        // Arrange
        mockNetworkManager.response = .failure(NetworkError.unknownError)
        
        let expectation = self.expectation(description: "Fetch students fails")
        
        // Act
        service.fetchStudents()
            .sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        // Assert
                        XCTAssertEqual(error, NetworkError.unknownError)
                        expectation.fulfill()
                    }
                },
                receiveValue: { _ in
                    XCTFail("Expected failure but got success")
                }
            )
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
}
