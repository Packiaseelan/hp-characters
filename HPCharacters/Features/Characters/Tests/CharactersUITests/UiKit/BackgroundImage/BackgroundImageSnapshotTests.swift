import XCTest
import SnapshotTesting
import SwiftUI

@testable import CharactersUiKit

final class BackgroundImageSnapshotTests: XCTestCase {
    @MainActor
    func testBackgroundImageSnapshots() {
        let configurations: [(name: String, device: ViewImageConfig, style: UIUserInterfaceStyle)] = [
            ("Portrait_Light", .devicePortrait, .light),
            ("Landscape_Light", .deviceLandscape, .light),
            ("Portrait_Dark", .devicePortrait, .dark),
            ("Landscape_Dark", .deviceLandscape, .dark),
        ]
        
        for config in configurations {
            let view = BackgroundImage()
            let viewController = UIHostingController(rootView: view)
            viewController.overrideUserInterfaceStyle = config.style
            
            assertSnapshot(
                of: viewController,
                as: .image(on: config.device, precision: 0.9),
                named: config.name,
                record: SnapshotTestConfig.record
            )
        }
    }
}
