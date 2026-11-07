//
//  DowloadedSong.swift
//  Components
//
//  Created by beri on 7.11.2026.
//

import Foundation
import SwiftData

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
