import XCTest
import SnapshotTesting
import SwiftUI
@testable import CharactersUiKit

final class StudentDetailsSnapshotTests: XCTestCase {
    
    @MainActor
    func testStudentDetailsSnapshots() {
        // Define sample student data
        let students: [StudentDetailsAttributes] = [
            StudentDetailsAttributes(
                image: "profileImage1",
                name: "Harry Potter",
                actor: "Daniel Radcliffe",
                species: "Human",
                gender: "Male",
                house: "Gryffindor",
                dateOfBirth: "31 July 1980",
                wizard: true,
                ancestry: "Half-blood",
                eyeColour: "Green",
                hairColour: "Black",
                patronus: "Stag",
                alternateActors: ["Actor 1", "Actor 2"],
                alive: true,
                onBack: {}
            ),
            StudentDetailsAttributes(
                image: "profileImage2",
                name: "Hermione Granger",
                actor: "Emma Watson",
                species: "Human",
                gender: "Female",
                house: "Gryffindor",
                dateOfBirth: nil,
                wizard: true,
                ancestry: "Muggle-born",
                eyeColour: "Brown",
                hairColour: "Brown",
                patronus: "Otter",
                alternateActors: [],
                alive: true,
                onBack: {}
            ),
            StudentDetailsAttributes(
                image: "profileImage3",
                name: "Albus Dumbledore",
                actor: "Richard Harris",
                species: "Human",
                gender: "Male",
                house: "Gryffindor",
                dateOfBirth: "1881",
                wizard: true,
                ancestry: "Half-blood",
                eyeColour: "Blue",
                hairColour: "Silver",
                patronus: "Phoenix",
                alternateActors: ["Michael Gambon"],
                alive: false,
                onBack: {}
            ),
            // Additional test cases can be added here for different data variations
        ]

        let configurations: [(name: String, device: ViewImageConfig, student: StudentDetailsAttributes, mode: UIUserInterfaceStyle)] = [
            // Light mode with different student details
            ("StudentDetails_HarryPotter_Light", .devicePortrait, students[0], .light),
            ("StudentDetails_HermioneGranger_Light", .devicePortrait, students[1], .light),
            ("StudentDetails_AlbusDumbledore_Light", .devicePortrait, students[2], .light),

            // Dark mode with different student details
            ("StudentDetails_HarryPotter_Dark", .devicePortrait, students[0], .dark),
            ("StudentDetails_HermioneGranger_Dark", .devicePortrait, students[1], .dark),
            ("StudentDetails_AlbusDumbledore_Dark", .devicePortrait, students[2], .dark),
            
            // Testing with different orientations (portrait and landscape)
            ("StudentDetails_HarryPotter_Landscape_Light", .deviceLandscape, students[0], .light),
            ("StudentDetails_HermioneGranger_Landscape_Light", .deviceLandscape, students[1], .light),
            ("StudentDetails_AlbusDumbledore_Landscape_Light", .deviceLandscape, students[2], .light),

            // Test without a date of birth (empty)
            ("StudentDetails_HermioneGranger_NoDOB_Light", .devicePortrait, students[1], .light),
            
            // Test with different numbers of alternate actors
            ("StudentDetails_HarryPotter_AlternateActors_Light", .devicePortrait, students[0], .light),
            ("StudentDetails_AlbusDumbledore_AlternateActor_Light", .devicePortrait, students[2], .light),
            
            // Test with a "not alive" student
            ("StudentDetails_AlbusDumbledore_Alive_False_Light", .devicePortrait, students[2], .light),
            
            // Pro Max device testing
            ("StudentDetails_HarryPotter_ProMax_Light", .deviceProMaxPortrait, students[0], .light),
            ("StudentDetails_HermioneGranger_ProMax_Light", .deviceProMaxPortrait, students[1], .light)
        ]
        
        for config in configurations {
            let studentDetails = StudentDetails(attributes: config.student)
            
            let viewController = UIHostingController(rootView: studentDetails)
            viewController.overrideUserInterfaceStyle = config.mode
            
            assertSnapshot(
                of: viewController,
                as: .image(on: config.device, precision: 0.9),
                named: config.name,
                record: SnapshotTestConfig.record
            )
        }
    }
}
