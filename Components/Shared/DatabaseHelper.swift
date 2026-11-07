import Foundation
import FirebaseFirestore

actor DatabaseHelper {
    func getUsers() async throws -> [User] {
        return [.mock]
    }
    
    func getProducts() async throws -> [Product] {
        guard let url = URL(string: "https://dummyjson.com/products") else {
            return []
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let productList = try JSONDecoder().decode(ProductArray.self, from: data)
        return productList.products
    }
    
    func getSongs() async throws -> [Song] {
        let snapshot = try await Firestore.firestore().collection("songs").getDocuments()
        
        var songs: [Song] = []
        for document in snapshot.documents {
            do {
                let song = try document.data(as: Song.self)
                songs.append(song)
            } catch {
                print("Şarkı okunamadı (id: \(document.documentID)): \(error)")
            }
        }
        return songs
    }
}
