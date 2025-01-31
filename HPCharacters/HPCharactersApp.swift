import SwiftUI
import Core
import Shared
import Characters
import NavigationManager
import NetworkManager
import Kingfisher

@main
struct HPCharactersApp: App {
    
    /// An instance of `AppInitializer` used to perform initial setup tasks for the app.
    private let initializer: AppInitializer = AppInitializer()
    private let imageAuthenticationChallenge = ImageAuthenticationChallenge()
    
    /// Initializes a new instance of `HPCharactersApp`.
    /// This initializer sets up the navigation manager and performs initial app setup.
    init() {
        // Perform initial setup tasks using the initializer.
        self.initializer.initialize()
        ImageDownloader.default.authenticationChallengeResponder = imageAuthenticationChallenge
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                AppNavigationView()
            }
        }
    }
}
