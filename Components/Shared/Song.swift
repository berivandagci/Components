import Foundation

struct Song: Codable, Identifiable {
    let id: String // Firestore için String ID çok daha rahattır
    let title: String
    let artist: String
    let duration: Double
    let songURL: String // Şarkının çalınacağı ses dosyası veya yayın linki
    let thumbnail: String // Albüm kapağı görseli
    
    var firstImage: String {
        thumbnail.isEmpty ? Constants.randomImage : thumbnail
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
