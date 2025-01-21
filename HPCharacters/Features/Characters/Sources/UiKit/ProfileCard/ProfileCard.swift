import SwiftUI

public struct ProfileAttributes {
    public let image: String
    public let name: String
    public let actor: String
    
    public init(image: String, name: String, actor: String) {
        self.image = image
        self.name = name
        self.actor = actor
    }
}

public struct ProfileCard: View {
    let attributes: ProfileAttributes
    
    public init(attributes: ProfileAttributes) {
        self.attributes = attributes
    }

    public var body: some View {
        ZStack {
            ProfileImage(imageUrl: attributes.image)
            VStack(spacing: 10) {
                
                Spacer()
                
                VStack {
                    Text(attributes.name)
                        .font(.headline)
                    
                    Text("\(attributes.actor)")
                        .font(.subheadline)
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity)
                .background(Color.white.opacity(0.5))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
        .background(Color.black.opacity(0.5))
        .cornerRadius(12)
        .padding(.horizontal, 8)
    }
}
