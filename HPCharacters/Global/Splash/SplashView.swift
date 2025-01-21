import SwiftUI
import NavigationManager
import Shared
import Core

struct SplashView: View {
    
    @StateObject private var viewModel: SplashViewModel
    
    init(navigation: NavigationManager) {
        _viewModel = StateObject(wrappedValue: SplashViewModel(navigationManager: navigation))
    }
    
    var body: some View {
        VStack {
            Image("logo")
            
            Text("Characters")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.yellow)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
    }
}
