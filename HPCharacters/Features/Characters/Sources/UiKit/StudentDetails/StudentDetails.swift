import SwiftUI

public struct StudentDetailsAttributes {
    public let image: String
    public let name: String
    public let actor: String
    
    public let species: String
    public let gender: String
    public let house: String
    public let dateOfBirth: String?
    public let wizard: Bool
    public let ancestry: String
    public let eyeColour: String
    public let hairColour: String
    public let patronus: String
    public let alternateActors: [String]
    public let alive: Bool
    
    public var onBack: () -> Void
    
    public init(image: String, name: String, actor: String, species: String, gender: String, house: String, dateOfBirth: String?, wizard: Bool, ancestry: String, eyeColour: String, hairColour: String, patronus: String, alternateActors: [String], alive: Bool, onBack: @escaping () -> Void) {
        self.image = image
        self.name = name
        self.actor = actor
        self.species = species
        self.gender = gender
        self.house = house
        self.dateOfBirth = dateOfBirth
        self.wizard = wizard
        self.ancestry = ancestry
        self.eyeColour = eyeColour
        self.hairColour = hairColour
        self.patronus = patronus
        self.alternateActors = alternateActors
        self.alive = alive
        self.onBack = onBack
    }
}

public struct StudentDetails: View {
    let attributes: StudentDetailsAttributes
    
    public init(attributes: StudentDetailsAttributes) {
        self.attributes = attributes
    }
    
    public var body: some View {
        
        ScrollView {
            VStack {
                HStack(alignment:.top) {
                    
                    IconButton(systemIconName: "chevron.left", action: {
                        attributes.onBack()
                    }, size: 50, iconColor: .yellow, backgroundColor: .gray.opacity(0.2))
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                ProfileImage(imageUrl: attributes.image)
                    .frame(maxWidth: 200, maxHeight: 200)
                
                Spacer(minLength: 30)
                
                VStack(spacing: 10) {
                    Spacer()
                    DetailsRowRow(label: "Name", value: attributes.name)
                    DetailsRowRow(label: "Actor", value: attributes.actor)
                    DetailsRowRow(label: "Ancestry", value: attributes.ancestry)
                    DetailsRowRow(label: "Patronus/Guardian", value: attributes.patronus)
                    DetailsRowRow(label: "Species", value: attributes.species)
                    DetailsRowRow(label: "Gender", value: attributes.gender)
                    DetailsRowRow(label: "DOB", value: attributes.dateOfBirth ?? "")
                    DetailsRowRow(label: "Eye color", value: attributes.eyeColour)
                    DetailsRowRow(label: "Hair color", value: attributes.hairColour)
                    DetailsRowRow(label: "House", value: attributes.house)
                    Spacer()
                }
                .padding()
                .background(Color.white)
                .ignoresSafeArea()
            }
        }
        .background(background)
    }
}

extension StudentDetails {
    private var background: some View {
        ProfileImage(imageUrl: attributes.image)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .blur(radius: 7)
            .ignoresSafeArea()
    }
}

struct DetailsRowRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.headline)

            Spacer()
            
            Text(value)
                .font(.body)
        }
        .padding(.vertical, 8)
    }
}
