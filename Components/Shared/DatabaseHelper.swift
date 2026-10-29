import Foundation
import FirebaseFirestore

struct DatabaseHelper {
    // Firestore'dan şarkı listesini çekme
    func getSongs() async throws -> [Song] {
        let snapshot = try await Firestore.firestore().collection("songs").getDocuments()
        
        return snapshot.documents.compactMap { document in
            let data = document.data()
            let id = document.documentID
            let title = data["title"] as? String ?? ""
            let artist = data["artist"] as? String ?? ""
            let duration = data["duration"] as? Double ?? 0.0
            let songURL = data["songURL"] as? String ?? ""
            let thumbnail = data["thumbnail"] as? String ?? ""
            
            return Song(id: id, title: title, artist: artist, duration: duration, songURL: songURL, thumbnail: thumbnail)
        }
    }
}
