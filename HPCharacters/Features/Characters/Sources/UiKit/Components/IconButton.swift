import SwiftUI

struct IconButton: View {
    var systemIconName: String
    var action: () -> Void
    var size: CGFloat = 44
    var iconColor: Color = .blue
    var backgroundColor: Color = .clear
    var cornerRadius: CGFloat = 8
    
    var body: some View {
        Button(action: action) {
            Image(systemName: systemIconName)
                .resizable()
                .scaledToFit()
                .frame(width: size * 0.5, height: size * 0.5)
                .foregroundColor(iconColor)
                .padding()
                .frame(width: size, height: size)
                .background(backgroundColor)
                .cornerRadius(cornerRadius)
        }
    }
}

struct IconButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            IconButton(systemIconName: "heart.fill", action: {
                print("Heart button pressed!")
            }, iconColor: .red, backgroundColor: .white, cornerRadius: 22)

            IconButton(systemIconName: "star", action: {
                print("Star button pressed!")
            }, size: 50, iconColor: .yellow, backgroundColor: .gray.opacity(0.2))
        }
        .padding()
    }
}
