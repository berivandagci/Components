import SwiftUI

struct LoginView: View {
    @StateObject private var authViewModel = AuthViewModel()
    @Binding var isAuthorized: Bool // Giriş başarılı olduğunda ana ekrana geçiş için
    
    @State private var isSigningUp = false // Kayıt olma / Giriş yapma modu geçişi için
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea() // Müzik uygulaması için koyu tema
            
            VStack(spacing: 24) {
                // Başlık / Logo Alanı
                VStack(spacing: 8) {
                    Image(systemName: "music.note.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.green)
                    
                    Text("MusicApp")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text(isSigningUp ? "Yeni hesap oluşturun" : "Hesabınıza giriş yapın")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 20)
                
                // Form Alanları
                VStack(spacing: 16) {
                    TextField("E-posta", text: $authViewModel.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.systemGray6).opacity(0.2))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    
                    SecureField("Şifre", text: $authViewModel.password)
                        .padding()
                        .background(Color(.systemGray6).opacity(0.2))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
                
                // Hata Mesajı Varsa Göster
                if !authViewModel.errorMessage.isEmpty {
                    Text(authViewModel.errorMessage)
                        .font(.caption)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }
                
                // Giriş / Kayıt Butonu
                Button {
                    Task {
                        let success = isSigningUp ? await authViewModel.signUp() : await authViewModel.signIn()
                        if success {
                            isAuthorized = true
                        }
                    }
                } label: {
                    Text(isSigningUp ? "Kayıt Ol" : "Giriş Yap")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding(.top, 10)
                
                // Mod Değiştirme Butonu (Giriş <-> Kayıt)
                Button {
                    isSigningUp.toggle()
                } label: {
                    Text(isSigningUp ? "Zaten hesabınız var mı? Giriş yapın" : "Hesabınız yok mu? Kayıt olun")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            .padding(24)
        }
    }
}
