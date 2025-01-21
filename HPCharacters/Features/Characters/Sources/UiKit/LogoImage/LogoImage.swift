import SwiftUI

public struct LogoImage: View {
    
    public init() { }

    public var body: some View {
        Image("logo1")
            .resizable()
            .scaledToFit()
            .frame(height: 100)
    }
}
