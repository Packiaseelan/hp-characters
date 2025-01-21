import SnapshotTesting

// Extending ViewImageConfig to create a custom configuration
extension ViewImageConfig {
    static var devicePortrait: ViewImageConfig {
        return .iPhone12(.portrait)
    }

    static var deviceLandscape: ViewImageConfig {
        return .iPhone12(.landscape)
    }
    
    static var deviceProMaxPortrait: ViewImageConfig {
        return .iPhone12ProMax(.portrait)
    }
}
