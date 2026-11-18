import SwiftUI
import SwiftData

struct DownloadedSongsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \DownloadedSong.downloadedAt, order: .reverse) private var downloadedSongs: [DownloadedSong]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(downloadedSongs) { song in
                    HStack(spacing: 12) {
                        AsyncImage(url: URL(string: song.thumbnail)) { image in
                            image.resizable().scaledToFill()
                        } placeholder: {
                            Color.gray.opacity(0.3)
                        }
                        .frame(width: 50, height: 50)
                        .cornerRadius(6)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(song.title)
                                .font(.headline)
                                .foregroundColor(.white)
                            Text(song.artist)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            playDownloadedSong(song)
                        }) {
                            Image(systemName: "play.circle.fill")
                                .font(.system(size: 32))
                                .foregroundColor(.green)
                        }
                    }
                    .listRowBackground(Color.black)
                }
                .onDelete(perform: deleteSongs)
            }
            .navigationTitle("İndirilenler")
            .scrollContentBackground(.hidden)
            .background(Color.black)
        }
    }
    
    private func playDownloadedSong(_ song: DownloadedSong) {
        guard let playbackURL = DownloadManager.shared.getAudioPlaybackURL(for: song) else {
            print("Oynatılacak geçerli bir URL bulunamadı!")
            return
        }
        print("Oynatıcıya gönderilen URL: \(playbackURL)")
        // Müzik oynatıcını (AVPlayer vb.) bu playbackURL ile başlat:
        // AudioPlayerManager.shared.play(url: playbackURL)
    }
    
    private func deleteSongs(at offsets: IndexSet) {
        for index in offsets {
            let song = downloadedSongs[index]
            DownloadManager.shared.deleteDownloadedSong(song, modelContext: modelContext)
        }
    }
}
