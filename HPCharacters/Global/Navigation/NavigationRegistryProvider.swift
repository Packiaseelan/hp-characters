import Core
import CharactersRoute
import NavigationManager
import Shared

/// A class responsible for providing a configured navigation manager registry.
/// This class is used to create and populate a `NavigationManagerRegistry` with
/// navigation managers for different modules or features within the application.
public class NavigationRegistryProvider {
    
    /// Creates and returns a configured `NavigationManagerRegistry`.
    /// This static method sets up the registry by registering navigation managers
    /// for various features, making them available for use in the application's navigation logic.
    /// - Returns: A `NavigationManagerRegistry` populated with registered navigation managers.
    public static func createRegistry() -> NavigationManagerRegistry {
        // Initialize a new navigation manager registry.
        let registry = NavigationManagerRegistry()
        
        // Create and register the navigation manager for the Characters module.
        let charactersManager = CharactersNavigationManager()
        registry.register(manager: charactersManager, forKey: ModuleIdentifier.characters)
        
        // Return the configured registry.
        return registry
    }
}
