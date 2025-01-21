import XCTest
import Combine
import Core
import CharactersData
import Foundation

@testable import Characters

class GetStudentDetailsServiceTests: XCTestCase {
    private var service: GetStudentDetailsService!
    private var mockNetworkManager: MockNetworkManager!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        service = GetStudentDetailsService(networkManager: mockNetworkManager)
    }
    
    override func tearDown() {
        mockNetworkManager = nil
        service = nil
        cancellables.removeAll()
        super.tearDown()
    }
    
    func testFetchStudentDetails_Success() {
        // Arrange
        let expectedStudents = [
            StudentModel(
                id: "9e3f7ce4-b9a7-4244-b709-dae5c1f1d4a8",
                name: "Harry Potter",
                alternateNames: ["The Boy Who Lived", "The Chosen One", "Undesirable No. 1", "Potty"],
                species: "human",
                gender: "male",
                house: "Gryffindor",
                dateOfBirth: "31-07-1980",
                yearOfBirth: 1980,
                wizard: true,
                ancestry: "half-blood",
                eyeColour: "green",
                hairColour: "black",
                wand: Wand(wood: "holly", core: "phoenix tail feather", length: 11),
                patronus: "stag",
                hogwartsStudent: true,
                hogwartsStaff: false,
                actor: "Daniel Radcliffe",
                alternateActors: [],
                alive: true,
                image: "https://ik.imagekit.io/hpapi/harry.jpg"
            )]
        
        let expectedData = try! JSONEncoder().encode(expectedStudents)
        
        mockNetworkManager.response = .success(expectedStudents)
        
        let expectation = self.expectation(description: "Fetch student details succeeds")
        
        // Act
        service.fetchStudentDetails(id: "9e3f7ce4-b9a7-4244-b709-dae5c1f1d4a8")
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
    
    func testFetchStudentDetails_Failure() {
        // Arrange
        mockNetworkManager.response = .failure(NetworkError.unknownError)
        
        let expectation = self.expectation(description: "Fetch student details fails")
        
        // Act
        service.fetchStudentDetails(id: "invalid-id")
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
