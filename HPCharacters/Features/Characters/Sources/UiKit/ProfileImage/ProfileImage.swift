import SwiftUI

public struct ProfileImage: View {
    let imageUrl: String
    
    public init(imageUrl: String) {
        self.imageUrl = imageUrl
    }
    
    public var body: some View {
        Group {
            if #available(iOS 15.0, *), !imageUrl.isEmpty {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
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
