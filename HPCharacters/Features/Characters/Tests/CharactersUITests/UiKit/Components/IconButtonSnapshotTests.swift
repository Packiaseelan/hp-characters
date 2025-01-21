import XCTest
import SnapshotTesting
import SwiftUI
@testable import CharactersUiKit

final class IconButtonSnapshotTests: XCTestCase {
    
    @MainActor
    func testIconButtonSnapshots() {
        let configurations: [(name: String, device: ViewImageConfig, size: CGFloat, iconColor: Color, backgroundColor: Color, cornerRadius: CGFloat)] = [
            ("Default_Light", .devicePortrait, 44, .blue, .clear, 8),
            ("LargeIcon_Light", .devicePortrait, 88, .red, .clear, 12),
            ("SmallIcon_Dark", .devicePortrait, 32, .green, .yellow, 4),
            ("RoundedBackground_Light", .devicePortrait, 44, .white, .blue, 22),
            ("Square_Light", .devicePortrait, 60, .black, .clear, 0),
        ]

        for config in configurations {
            let iconButton = IconButton(
                systemIconName: "star.fill", // Example system icon
                action: { print("Button tapped") },
                size: config.size,
                iconColor: config.iconColor,
                backgroundColor: config.backgroundColor,
                cornerRadius: config.cornerRadius
            )
            
            let viewController = UIHostingController(rootView: iconButton)
            
            assertSnapshot(
                of: viewController,
                as: .image(on: config.device),
                named: config.name,
                record: SnapshotTestConfig.record
            )
        }
    }
}
