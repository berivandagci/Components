import Foundation
import SwiftData
import SwiftUI

struct DownloadsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \DownloadedSong.downloadedAt, order: .reverse) private var downloadedSongs: [DownloadedSong]

    var body: some View {
        List {
            ForEach(downloadedSongs) { song in
                HStack(spacing: 12) {
                    thumbnailView(for: song.thumbnail)

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

    @ViewBuilder
    private func thumbnailView(for rawURL: String) -> some View {
        if let url = URL(string: rawURL),
           let scheme = url.scheme?.lowercased(),
           ["http", "https"].contains(scheme),
           url.host != nil {
            AsyncImage(url: url) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 50, height: 50)
            .clipShape(RoundedRectangle(cornerRadius: 6))
        } else {
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 50, height: 50)
                .overlay {
                    Image(systemName: "music.note")
                        .foregroundStyle(.white.opacity(0.7))
                }
        }
    }

    private func playDownloadedSong(_ song: DownloadedSong) {
        guard let playbackURL = DownloadManager.shared.getAudioPlaybackURL(for: song),
              let scheme = playbackURL.scheme?.lowercased(),
              (scheme == "file" || (["http", "https"].contains(scheme) && playbackURL.host != nil)) else {
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
