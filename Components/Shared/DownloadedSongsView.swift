import Foundation
import SwiftData
import SwiftUI

@Model
final class DownloadedSong {
    @Attribute(.unique) var songID: String
    var title: String
    var artist: String
    var thumbnail: String
    var songURL: String
    var localPath: String?
    var downloadedAt: Date

    init(
        songID: String,
        title: String,
        artist: String,
        thumbnail: String,
        songURL: String,
        localPath: String? = nil,
        downloadedAt: Date = .now
    ) {
        self.songID = songID
        self.title = title
        self.artist = artist
        self.thumbnail = thumbnail
        self.songURL = songURL
        self.localPath = localPath
        self.downloadedAt = downloadedAt
    }
}

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
                        .clipShape(RoundedRectangle(cornerRadius: 6))

                        VStack(alignment: .leading, spacing: 4) {
                            Text(song.title)
                                .font(.headline)
                                .foregroundStyle(.white)
                            Text(song.artist)
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                        }

                        Spacer()

                        Button {
                            playDownloadedSong(song)
                        } label: {
                            Image(systemName: "play.circle.fill")
                                .font(.system(size: 32))
                                .foregroundStyle(.green)
                        }
                        .buttonStyle(.plain)
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
            return
        }
        AudioPlayerManager.shared.play(url: playbackURL)
    }

    private func deleteSongs(at offsets: IndexSet) {
        for index in offsets {
            let song = downloadedSongs[index]
            if let playbackURL = DownloadManager.shared.getAudioPlaybackURL(for: song),
               AudioPlayerManager.shared.currentURL == playbackURL {
                AudioPlayerManager.shared.stop()
            }
            DownloadManager.shared.deleteDownloadedSong(song, modelContext: modelContext)
        }
    }
}
