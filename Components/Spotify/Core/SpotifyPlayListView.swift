import SwiftUI
import SwiftData
import SwiftfulUI
import SwiftfulRouting

struct SpotifyPlayListView: View {
    var song: Song = .mock
    var songs: [Song] = []
    var user: User = .mock
    @Environment(\.router) var router
    @Environment(\.modelContext) private var modelContext
    @Query private var downloads: [DownloadedSong]
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    headerImage
                    
                    PlaylistDescriptionCell(
                        descriptionText: song.artist ?? "",
                        userName: user.firstName,
                        subheadline: song.title ?? "",
                        isDownloaded: isDownloaded,
                        onAddToPlaylistPressed: {},
                        onSharedPressed: {},
                        onDownLoadPressed: { downloadSong() },
                        onEllipsisPressed: {},
                        onShufflePressed: {},
                        onPlayPressed: {}
                    )
                    .padding(16)
                    
                    VStack(spacing: 12) {
                        ForEach(songs) { item in
                            SongRowCell(
                                imageName: item.firstImage,
                                title: item.title ?? "",
                                subtitle: item.artist
                            )
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .overlay(alignment: .topLeading) {
            Image(systemName: "chevron.left")
                .font(.title3.bold())
                .foregroundStyle(.spotifyWhite)
                .padding(12)
                .background(Color.black.opacity(0.5))
                .clipShape(Circle())
                .padding(16)
                .onTapGesture {
                    router.dismissScreen()
                }
        }
    }

    private var headerImage: some View {
        Rectangle()
            .fill(Color.spotifyDarkGray)
            .aspectRatio(1, contentMode: .fit)
            .overlay(
                ImageLoaderView(urlString: song.firstImage)
            )
    }
    
    private var isDownloaded: Bool {
        guard let id = song.id else { return false }
        return downloads.contains(where: { $0.songID == id })
    }
    
    private func downloadSong() {
        guard let id = song.id else { return }
        guard !isDownloaded else { return }
        
        modelContext.insert(
            DownloadedSong(
                songID: id,
                title: song.title ?? "",
                artist: song.artist ?? "",
                thumbnail: song.firstImage,
                songURL: song.songURL ?? ""
            )
        )
    }
}

#Preview {
    RouterView { router in
        SpotifyPlayListView(song: .mock, songs: [.mock], user: .mock)
    }
    .modelContainer(for: DownloadedSong.self, inMemory: true)
}
