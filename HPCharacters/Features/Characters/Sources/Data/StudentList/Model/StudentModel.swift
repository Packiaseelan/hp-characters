import Foundation
import Core

public struct StudentModel: BaseDataModel, Decodable, Equatable, Encodable {
    public static func == (lhs: StudentModel, rhs: StudentModel) -> Bool {
        lhs.id == rhs.id
    }
    
    public let id, name: String
    public let alternateNames: [String]
    public let species: String
    public let gender: String
    public let house: String
    public let dateOfBirth: String?
    public let yearOfBirth: Int?
    public let wizard: Bool
    public let ancestry: String
    public let eyeColour: String
    public let hairColour: String
    public let wand: Wand
    public let patronus: String
    public let hogwartsStudent, hogwartsStaff: Bool
    public let actor: String
    public let alternateActors: [String]
    public let alive: Bool
    public let image: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case alternateNames = "alternate_names"
        case species, gender, house, dateOfBirth, yearOfBirth, wizard, ancestry, eyeColour, hairColour, wand, patronus, hogwartsStudent, hogwartsStaff, actor
        case alternateActors = "alternate_actors"
        case alive, image
    }
    
    public init(id: String, name: String, alternateNames: [String], species: String, gender: String, house: String, dateOfBirth: String?, yearOfBirth: Int?, wizard: Bool, ancestry: String, eyeColour: String, hairColour: String, wand: Wand, patronus: String, hogwartsStudent: Bool, hogwartsStaff: Bool, actor: String, alternateActors: [String], alive: Bool, image: String) {
        self.id = id
        self.name = name
        self.alternateNames = alternateNames
        self.species = species
        self.gender = gender
        self.house = house
        self.dateOfBirth = dateOfBirth
        self.yearOfBirth = yearOfBirth
        self.wizard = wizard
        self.ancestry = ancestry
        self.eyeColour = eyeColour
        self.hairColour = hairColour
        self.wand = wand
        self.patronus = patronus
        self.hogwartsStudent = hogwartsStudent
        self.hogwartsStaff = hogwartsStaff
        self.actor = actor
        self.alternateActors = alternateActors
        self.alive = alive
        self.image = image
    }
}

// MARK: - Wand
public struct Wand: Codable {
    public let wood: String
    public let core: String
    public let length: Double?
    
    public init(wood: String, core: String, length: Double?) {
        self.wood = wood
        self.core = core
        self.length = length
    }
}
