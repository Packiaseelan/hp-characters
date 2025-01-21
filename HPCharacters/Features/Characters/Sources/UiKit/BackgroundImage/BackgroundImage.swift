import SwiftUI

public struct BackgroundImage: View {
    
    public init() { }

    public var body: some View {
        Image("poster")
            .resizable()
            .scaledToFill()
            .blur(radius: 9)
            .ignoresSafeArea()
    }
}
