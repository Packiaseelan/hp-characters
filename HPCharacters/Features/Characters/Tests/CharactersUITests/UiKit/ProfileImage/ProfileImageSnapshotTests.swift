import XCTest
import SnapshotTesting
import SwiftUI
@testable import CharactersUiKit

final class ProfileImageSnapshotTests: XCTestCase {
    
    @MainActor
    func testProfileImageSnapshots() {
        let configurations: [(name: String, device: ViewImageConfig, imageUrl: String, mode: UIUserInterfaceStyle)] = [
            // Testing with valid image URL and different devices
            ("ProfileImage_ValidImage_Light", .devicePortrait, "https://example.com/image1.jpg", .light),
            ("ProfileImage_ValidImage_Landscape_Light", .deviceLandscape, "https://example.com/image2.jpg", .light),
            
            // Testing with empty image URL and fallback image
            ("ProfileImage_EmptyUrl_Light", .devicePortrait, "", .light),
            ("ProfileImage_EmptyUrl_Landscape_Light", .deviceLandscape, "", .light),
            
            // Testing with a valid URL and dark mode
            ("ProfileImage_ValidImage_Dark", .devicePortrait, "https://example.com/image1.jpg", .dark),
            ("ProfileImage_ValidImage_Landscape_Dark", .deviceLandscape, "https://example.com/image2.jpg", .dark),
            
            // Testing with empty URL in dark mode (fallback)
            ("ProfileImage_EmptyUrl_Dark", .devicePortrait, "", .dark),
            ("ProfileImage_EmptyUrl_Landscape_Dark", .deviceLandscape, "", .dark),
            
            // Testing AsyncImage behavior
            ("ProfileImage_AsyncImage_Light", .devicePortrait, "https://example.com/asyncImage1.jpg", .light)
        ]
        
        for config in configurations {
            let profileImage = ProfileImage(imageUrl: config.imageUrl)
            
            let viewController = UIHostingController(rootView: profileImage)
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
