import SwiftUI
import Kingfisher

struct ImageView: View {
    
    var url: URL?
    @State var isImageLoaded = false
    
    init(imageUrl: String?) {
        if let imageUrl = imageUrl, let validUrl = URL(string: imageUrl) {
            self.url = validUrl
        } else {
            self.url = nil
        }
    }
    
    var body: some View {
        ZStack {
            if !isImageLoaded {
                ProgressView()
            }
            
            if self.url != nil {
                
                KFImage(url)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                EmptyView()
            }
        }
    }
}
