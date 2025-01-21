import XCTest
import SnapshotTesting
import SwiftUI
@testable import CharactersUiKit

final class ProfileCardSnapshotTests: XCTestCase {
    
    @MainActor
    func testProfileCardSnapshots() {
        // Define profiles for testing
        let profiles: [ProfileAttributes] = [
            ProfileAttributes(image: "profileImage1", name: "John Doe", actor: "Actor"),
            ProfileAttributes(image: "profileImage2", name: "Jane Smith", actor: "Actress"),
            ProfileAttributes(image: "profileImage3", name: "A very long name for testing", actor: "Famous Actor with a really long name"),
            ProfileAttributes(image: "profileImage4", name: "Steve Rogers", actor: "Super Soldier"),
            ProfileAttributes(image: "profileImage5", name: "Mia", actor: "Director"),
            ProfileAttributes(image: "profileImage6", name: "A", actor: "X")
        ]

        // Define configurations for each test case
        let configurations: [(name: String, device: ViewImageConfig, profile: ProfileAttributes, mode: UIUserInterfaceStyle)] = [
            // Portrait and Landscape with different profile configurations
            ("ProfileCard_Default_Light", .devicePortrait, profiles[0], .light),
            ("ProfileCard_Landscape_Light", .deviceLandscape, profiles[0], .light),
            ("ProfileCard_LargeName_Light", .devicePortrait, profiles[2], .light),
            ("ProfileCard_LargeActorName_Light", .devicePortrait, profiles[2], .light),
            ("ProfileCard_SmallName_Light", .devicePortrait, profiles[4], .light),
            ("ProfileCard_ShortName_Light", .devicePortrait, profiles[5], .light),
            
            // Dark mode variations
            ("ProfileCard_Default_Dark", .devicePortrait, profiles[1], .dark),
            ("ProfileCard_Landscape_Dark", .deviceLandscape, profiles[1], .dark),
            ("ProfileCard_LargeName_Dark", .devicePortrait, profiles[2], .dark),
            ("ProfileCard_LargeActorName_Dark", .devicePortrait, profiles[2], .dark),
            ("ProfileCard_SmallName_Dark", .devicePortrait, profiles[4], .dark),
            ("ProfileCard_ShortName_Dark", .devicePortrait, profiles[5], .dark),
            
            // Orientation, image size, and profile card background styles
            ("ProfileCard_WithImage_Light", .devicePortrait, profiles[3], .light),
            ("ProfileCard_WithImage_Landscape_Light", .deviceLandscape, profiles[3], .light),
            ("ProfileCard_SmallImage_Light", .devicePortrait, profiles[4], .light),
            ("ProfileCard_Iconic_Light", .devicePortrait, profiles[5], .light)
        ]
        
        for config in configurations {
            let profileCard = ProfileCard(attributes: config.profile)
            
            let viewController = UIHostingController(rootView: profileCard)
            viewController.overrideUserInterfaceStyle = config.mode
            
            assertSnapshot(
                of: viewController,
                as: .image(on: config.device),
                named: config.name,
                record: SnapshotTestConfig.record
            )
        }
    }
}
