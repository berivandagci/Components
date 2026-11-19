import Foundation
import SwiftData

class DownloadManager {
    static let shared = DownloadManager()
    private init() {}

    // 1. Cihaz içinde dosyanın kaydedileceği yolu oluşturur
    func getLocalFilePath(for fileName: String) -> URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return documentsDirectory.appendingPathComponent(fileName)
    }
    
    // SwiftData'da saklanan değerden (dosya adı ya da eski tam yol) güncel dosya yolunu üretir.
    // Uygulama kurulum yolu değişebildiği için tam yol yerine sadece dosya adını kullanıyoruz.
    private func resolveFileURL(from storedPath: String) -> URL? {
        let fileName = URL(fileURLWithPath: storedPath).lastPathComponent
        return getLocalFilePath(for: fileName)
    }

    // 2. İnternetten şarkıyı indirir, telefona kaydeder ve SwiftData'ya işler
    func downloadAndSaveSong(song: Song, modelContext: ModelContext, completion: @escaping (Result<URL, Error>) -> Void) {
        let songID = song.id ?? song.songURL ?? UUID().uuidString
        
        guard let songURLString = song.songURL,
              let remoteURL = URL(string: songURLString) else {
            DispatchQueue.main.async {
                completion(.failure(NSError(domain: "DownloadManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Geçersiz şarkı URL'si."])))
            }
            return
        }
        
        let sanitizedFileName = songID.replacingOccurrences(of: "/", with: "_")
        let fileName = "\(sanitizedFileName).mp3"
        
        guard let destinationURL = getLocalFilePath(for: fileName) else {
            DispatchQueue.main.async {
                completion(.failure(NSError(domain: "DownloadManager", code: -3, userInfo: [NSLocalizedDescriptionKey: "Dosya yolu oluşturulamadı."])))
            }
            return
        }
        
        // Zaten indirilmişse tekrar indirmeden veritabanını günceller
        if FileManager.default.fileExists(atPath: destinationURL.path) {
            DispatchQueue.main.async {
                self.saveToSwiftData(song: song, songID: songID, fileName: fileName, modelContext: modelContext)
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
                    self.saveToSwiftData(song: song, songID: songID, fileName: fileName, modelContext: modelContext)
                    completion(.success(destinationURL))
                }
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }
        task.resume()
    }
    
    // 3. SwiftData'ya kayıt yapar (localPath alanında artık sadece dosya adı tutulur)
    private func saveToSwiftData(song: Song, songID: String, fileName: String, modelContext: ModelContext) {
        let downloadedSong = DownloadedSong(
            songID: songID,
            title: song.title ?? "Bilinmeyen Şarkı",
            artist: song.artist ?? "Bilinmeyen Sanatçı",
            thumbnail: song.thumbnail ?? Constants.randomImage,
            songURL: song.songURL ?? "",
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

    // 4. Oynatma Kaynağı Kararı (Ana listedeki 'Song' modeli için)
    func getAudioPlaybackURL(for song: Song) -> URL? {
        let songID = song.id ?? song.songURL ?? ""
        let sanitizedFileName = songID.replacingOccurrences(of: "/", with: "_")
        let fileName = "\(sanitizedFileName).mp3"
        
        if let localURL = getLocalFilePath(for: fileName),
           FileManager.default.fileExists(atPath: localURL.path) {
            print("📴 Yerel dosya çalınıyor: \(localURL.path)")
            return localURL
        }
        
        print("🌐 Uzak URL çalınıyor: \(song.songURL ?? "")")
        return URL(string: song.songURL ?? "")
    }

    // 5. Oynatma Kaynağı Kararı (İndirilenler ekranındaki 'DownloadedSong' modeli için)
    func getAudioPlaybackURL(for song: DownloadedSong) -> URL? {
        if let stored = song.localPath,
           let fileURL = resolveFileURL(from: stored),
           FileManager.default.fileExists(atPath: fileURL.path) {
            print("📴 Yerel dosya çalınıyor: \(fileURL.path)")
            return fileURL
        }
        
        print("🌐 Uzak URL çalınıyor: \(song.songURL)")
        return URL(string: song.songURL)
    }

    // 6. Şarkıyı hem telefondaki dosyadan hem SwiftData'dan siler
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
