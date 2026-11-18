import SwiftUI
import SwiftData // <--- SwiftData'yı import etmeyi unutma

struct SongListView: View {
    @StateObject private var viewModel = SongViewModel()
    
    // SwiftData veritabanı işlemlerini yapmak için context'i çağırıyoruz
    @Environment(\.modelContext) private var modelContext
    
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
                            
                            // --- İNDİRME BUTONU ---
                            Button {
                                DownloadManager.shared.downloadAndSaveSong(song: song, modelContext: modelContext) { result in
                                    switch result {
                                    case .success(let localURL):
                                        print("Şarkı başarıyla indirildi: \(localURL.path)")
                                    case .failure(let error):
                                        print("İndirme hatası: \(error.localizedDescription)")
                                    }
                                }
                            } label: {
                                Image(systemName: "arrow.down.circle")
                                    .font(.title2)
                                    .foregroundColor(.accentColor)
                            }
                            .buttonStyle(.borderless) // Listenin tamamının tıklanmasını engellemek için
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
