import SwiftUI

public struct ProfileImage: View {
    let imageUrl: String
    
    public init(imageUrl: String) {
        self.imageUrl = imageUrl
    }
    
    public var body: some View {
        Group {
            if #available(iOS 15.0, *), !imageUrl.isEmpty {
                ImageView(imageUrl: imageUrl)
                    .frame(width: UIScreen.main.bounds.width / 2 - 24)
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                    .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
