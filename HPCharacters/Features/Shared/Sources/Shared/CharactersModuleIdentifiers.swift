/// An enumeration that defines identifiers for different character-related screens.
/// This enum is used to uniquely identify screens within the application, particularly
/// in contexts where navigation or screen management is required.
public enum CharactersScreenIdentifier: Hashable {
    case studentList
    case studentDetails(id: String)
}

/// A class that provides static identifiers for character-related mappings.
/// This class is used to define string-based identifiers that can be used
/// to map or reference specific character-related components or functionalities.
public class CharactersMapperIdentifier {
    public static let studentList = "studentList";
}
