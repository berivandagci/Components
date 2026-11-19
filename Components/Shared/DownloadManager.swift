import Foundation
import SwiftData

class DownloadManager {
    static let shared = DownloadManager()
    private init() {}

    func getLocalFilePath(for fileName: String) -> URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return documentsDirectory.appendingPathComponent(fileName)
    }

    private func resolveFileURL(from storedPath: String) -> URL? {
        let fileName = URL(fileURLWithPath: storedPath).lastPathComponent
        return getLocalFilePath(for: fileName)
    }

    private func validRemoteURL(from rawString: String?) -> URL? {
        guard let rawString = rawString?.trimmingCharacters(in: .whitespacesAndNewlines),
              !rawString.isEmpty,
              let url = URL(string: rawString),
              let scheme = url.scheme?.lowercased(),
              ["http", "https"].contains(scheme),
              url.host != nil else {
            return nil
        }
        return url
    }

    func downloadAndSaveSong(song: Song, modelContext: ModelContext, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let remoteURL = validRemoteURL(from: song.songURL) else {
            DispatchQueue.main.async {
                completion(.failure(NSError(domain: "DownloadManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Geçersiz veya boş şarkı URL'si."])))
            }
            return
        }

        let songID = song.id ?? remoteURL.absoluteString
        let sanitizedFileName = songID.replacingOccurrences(of: "/", with: "_")
        let fileName = "\(sanitizedFileName).mp3"

        guard let destinationURL = getLocalFilePath(for: fileName) else {
            DispatchQueue.main.async {
                completion(.failure(NSError(domain: "DownloadManager", code: -3, userInfo: [NSLocalizedDescriptionKey: "Dosya yolu oluşturulamadı."])))
            }
            return
        }

        if FileManager.default.fileExists(atPath: destinationURL.path) {
            DispatchQueue.main.async {
                self.saveToSwiftData(song: song, songID: songID, validSongURL: remoteURL.absoluteString, fileName: fileName, modelContext: modelContext)
                completion(.success(destinationURL))
            }
            return
        }

        let task = URLSession.shared.downloadTask(with: remoteURL) { location, _, error in
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }

            guard let location = location else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "DownloadManager", code: -2, userInfo: [NSLocalizedDescriptionKey: "İndirilen dosya konumu bulunamadı."])))
                }
                return
            }

            do {
                if FileManager.default.fileExists(atPath: destinationURL.path) {
                    try FileManager.default.removeItem(at: destinationURL)
                }
                try FileManager.default.moveItem(at: location, to: destinationURL)

                DispatchQueue.main.async {
                    self.saveToSwiftData(song: song, songID: songID, validSongURL: remoteURL.absoluteString, fileName: fileName, modelContext: modelContext)
                    completion(.success(destinationURL))
                }
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }
        task.resume()
    }

    private func saveToSwiftData(song: Song, songID: String, validSongURL: String, fileName: String, modelContext: ModelContext) {
        let resolvedThumbnail = validRemoteURL(from: song.thumbnail)?.absoluteString ?? Constants.randomImage

        let downloadedSong = DownloadedSong(
            songID: songID,
            title: song.title ?? "Bilinmeyen Şarkı",
            artist: song.artist ?? "Bilinmeyen Sanatçı",
            thumbnail: resolvedThumbnail,
            songURL: validSongURL,
            localPath: fileName,
            downloadedAt: Date()
        )

        modelContext.insert(downloadedSong)

        do {
            try modelContext.save()
            print("Şarkı başarıyla SwiftData'ya kaydedildi: \(fileName)")
        } catch {
            print("SwiftData kayıt hatası: \(error.localizedDescription)")
        }
    }

    func getAudioPlaybackURL(for song: Song) -> URL? {
        let songID = song.id ?? song.songURL ?? ""
        let sanitizedFileName = songID.replacingOccurrences(of: "/", with: "_")
        let fileName = "\(sanitizedFileName).mp3"

        if let localURL = getLocalFilePath(for: fileName),
           FileManager.default.fileExists(atPath: localURL.path) {
            print("📴 Yerel dosya çalınıyor: \(localURL.path)")
            return localURL
        }

        guard let remoteURL = validRemoteURL(from: song.songURL) else {
            print("⚠️ Geçersiz veya boş uzak şarkı URL'si")
            return nil
        }

        print("🌐 Uzak URL çalınıyor: \(remoteURL.absoluteString)")
        return remoteURL
    }

    func getAudioPlaybackURL(for song: DownloadedSong) -> URL? {
        if let stored = song.localPath,
           let fileURL = resolveFileURL(from: stored),
           FileManager.default.fileExists(atPath: fileURL.path) {
            print("📴 Yerel dosya çalınıyor: \(fileURL.path)")
            return fileURL
        }

        guard let remoteURL = validRemoteURL(from: song.songURL) else {
            print("⚠️ Geçersiz veya boş kayıtlı şarkı URL'si")
            return nil
        }

        print("🌐 Uzak URL çalınıyor: \(remoteURL.absoluteString)")
        return remoteURL
    }

    func deleteDownloadedSong(_ song: DownloadedSong, modelContext: ModelContext) {
        if let stored = song.localPath,
           let fileURL = resolveFileURL(from: stored),
           FileManager.default.fileExists(atPath: fileURL.path) {
            try? FileManager.default.removeItem(at: fileURL)
            print("🗑️ Fiziksel dosya silindi: \(fileURL.path)")
        }

        modelContext.delete(song)
        do {
            try modelContext.save()
            print("🗑️ SwiftData kaydı silindi.")
        } catch {
            print("SwiftData silme hatası: \(error.localizedDescription)")
        }
    }
}
