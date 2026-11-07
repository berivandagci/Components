import Foundation
import FirebaseFirestore // Firestore kütüphanesinin import edildiğinden emin ol

struct Song: Codable, Identifiable {
    @DocumentID var id: String? // Firebase doküman ID'sini otomatik yakalar
    let title: String?
    let artist: String?
    let duration: Double?
    let songURL: String?
    let thumbnail: String?
    
    var firstImage: String {
        guard let thumbnail, !thumbnail.isEmpty else {
            return Constants.randomImage
        }
        return thumbnail
    }
    
    // Test amaçlı sahte (mock) şarkı verisi
    static var mock: Song {
        Song(
            id: "12345",
            title: "Örnek Şarkı",
            artist: "Sanatçı Adı",
            duration: 180.0,
            songURL: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
            thumbnail: Constants.randomImage
        )
    }
}
struct SongRow {
    let title: String
    let songs: [Song]
}
