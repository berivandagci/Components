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
        
        return snapshot.documents.compactMap { document in
            try? document.data(as: Song.self)
        }
    }
}
