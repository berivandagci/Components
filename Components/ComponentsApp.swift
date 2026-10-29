import SwiftUI
import SwiftfulRouting
import FirebaseCore
import FirebaseAuth

@main
struct ComponentsApp: App {
    
    init() {
        FirebaseApp.configure() // Firebase'i burada başlatıyoruz
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

// Oturum durumuna göre Login veya Ana Uygulama arasında geçiş yapan kök yapı
struct RootView: View {
    @State private var isAuthorized = Auth.auth().currentUser != nil
    
    var body: some View {
        Group {
            if isAuthorized {
                RouterView { _ in
                    ContentView() // Veya SongListView()
                }
            } else {
                LoginView(isAuthorized: $isAuthorized)
            }
        }
    }
}

extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
