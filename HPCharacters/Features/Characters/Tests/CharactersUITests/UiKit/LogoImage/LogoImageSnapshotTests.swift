import XCTest
import SnapshotTesting
import SwiftUI
@testable import CharactersUiKit

final class LogoImageSnapshotTests: XCTestCase {
    
    @MainActor
    func testLogoImageSnapshots() {
        let configurations: [(name: String, device: ViewImageConfig, height: CGFloat)] = [
            ("LogoImage_Default_Light", .devicePortrait, 100),
            ("LogoImage_Large_Light", .devicePortrait, 200),
            ("LogoImage_Small_Light", .devicePortrait, 50),
            ("LogoImage_Landscape_Light", .deviceLandscape, 100),
            ("LogoImage_Default_Dark", .devicePortrait, 100)
        ]
        
        for config in configurations {
            let logoImage = LogoImage()
                .frame(height: config.height)
            
            let viewController = UIHostingController(rootView: logoImage)
            
            assertSnapshot(
                of: viewController,
                as: .image(on: config.device, precision: 0.9),
                named: config.name,
                record: SnapshotTestConfig.record
            )
        }
    }
}
