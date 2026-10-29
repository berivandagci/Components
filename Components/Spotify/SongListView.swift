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
                            // Albüm kapağı (Daha önce eklediğimiz ImageLoaderView'ı kullanıyoruz)
                            ImageLoaderView(urlString: song.thumbnail)
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(song.title)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(song.artist)
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
