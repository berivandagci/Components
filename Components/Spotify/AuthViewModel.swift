import Foundation
import FirebaseAuth

@MainActor
class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var isAuthenticated = false
    
    // Giriş yapma fonksiyonu
    func signIn() async -> Bool {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Lütfen tüm alanları doldurun."
            return false
        }
        
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
            isAuthenticated = true
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
    
    // Kayıt olma fonksiyonu
    func signUp() async -> Bool {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Lütfen tüm alanları doldurun."
            return false
        }
        
        do {
            try await Auth.auth().createUser(withEmail: email, password: password)
            isAuthenticated = true
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
    
    // Çıkış yapma
    func signOut() {
        do {
            try Auth.auth().signOut()
            isAuthenticated = false
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
