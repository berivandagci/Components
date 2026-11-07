import SwiftUI

struct SongListView: View {
    @StateObject private var viewModel = SongViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea() // Müzik uygulaması için koyu tema
                
                if viewModel.isLoading {
                    ProgressView("Şarkılar Yükleniyor...")
                        .foregroundColor(.white)
                } else {
                    List(viewModel.songs) { song in
                        HStack(spacing: 16) {
                            // Albüm kapağı (Güvenli olan firstImage kullanıyoruz)
                            ImageLoaderView(urlString: song.firstImage)
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(song.title ?? "Bilinmeyen Şarkı")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(song.artist ?? "Bilinmeyen Sanatçı")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                        }
                        .listRowBackground(Color.black)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Şarkılar")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.fetchSongs()
            }
        }
    }
}

#Preview {
    SongListView()
}
