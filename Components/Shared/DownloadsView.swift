//
//  DownloadsView.swift
//  Components
//
//  Created by beri on 7.11.2026.
//

import SwiftUI
import SwiftData

struct DownloadsView: View {
    @Query(sort: \DownloadedSong.downloadedAt, order: .reverse)
    private var downloads: [DownloadedSong]
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            if downloads.isEmpty {
                Text("Henüz indirilen şarkı yok")
                    .foregroundStyle(.spotifyLightGray)
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(downloads) { item in
                            SongRowCell(
                                imageName: item.thumbnail,
                                title: item.title,
                                subtitle: item.artist
                            )
                        }
                    }
                    .padding(16)
                }
            }
        }
    }
}

#Preview {
    DownloadsView()
        .modelContainer(for: DownloadedSong.self, inMemory: true)
}
