import Foundation

struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String?
    let category: String
    let thumbnail: String
    let images: [String]
    
    var firstImage: String {
        images.first ?? Constants.randomImage
    }
    
    static var mock: Product {
        Product(
            id: 1,
            title: "Örnek Müzik Ürünü",
            description: "Bu şarkı veya çalma listesi için örnek bir açıklamadır.",
            price: 9.99,
            discountPercentage: 0.0,
            rating: 4.5,
            stock: 100,
            brand: "Spotify",
            category: "Müzik",
            thumbnail: Constants.randomImage,
            images: [Constants.randomImage]
        )
    }
}

struct ProductRow {
    let title: String
    let product: [Product]
}

struct ProductArray: Codable {
    let products: [Product]
}
