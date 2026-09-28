//
//  Product.swift
//  Components
//
//  Created by beri on 10.09.2026.
//

import Foundation

struct ProductWelcome: Codable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int

    enum CodingKeys: String, CodingKey {
        case products = "products"
        case total = "total"
        case skip = "skip"
        case limit = "limit"
    }
}

// MARK: - Product
struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let category: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Double
    let tags: [String]
    let brand: String?
    let sku: String
    let weight: Double
    let dimensions: Dimensions
    let warrantyInformation: String
    let shippingInformation: String
    let availabilityStatus: String
    let reviews: [Review]
    let returnPolicy: String
    let minimumOrderQuantity: Double
    let meta: Meta
    let images: [String]
    let thumbnail: String
    
    var firstImage: String {
        images.first ?? Constants.randomImage
    }
    
    // Netflix klonundaki hücreler için rastgele recentlyAdded desteği
    var isRecentlyAdded: Bool = {
        return Int.random(in: 1...4) == 1
     
    } ()
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case category = "category"
        case price = "price"
        case discountPercentage = "discountPercentage"
        case rating = "rating"
        case stock = "stock"
        case tags = "tags"
        case brand = "brand"
        case sku = "sku"
        case weight = "weight"
        case dimensions = "dimensions"
        case warrantyInformation = "warrantyInformation"
        case shippingInformation = "shippingInformation"
        case availabilityStatus = "availabilityStatus"
        case reviews = "reviews"
        case returnPolicy = "returnPolicy"
        case minimumOrderQuantity = "minimumOrderQuantity"
        case meta = "meta"
        case images = "images"
        case thumbnail = "thumbnail"
    }
    
    static var mock: Product {
        Product(
            id: 123,
            title: "Mock Product",
            description: "Mock description goes here.",
            category: "beauty",
            price: 9.99,
            discountPercentage: 0.0,
            rating: 5.0,
            stock: 10.0,
            tags: ["tag1"],
            brand: "Mock Brand",
            sku: "SKU123",
            weight: 1.0,
            dimensions: Dimensions(width: 1.0, height: 1.0, depth: 1.0),
            warrantyInformation: "No warranty",
            shippingInformation: "Ships in 1 week",
            availabilityStatus: "In Stock",
            reviews: [],
            returnPolicy: "No return policy",
            minimumOrderQuantity: 1.0,
            meta: Meta(createdAt: "", updatedAt: "", barcode: "", qrCode: ""),
            images: [Constants.randomImage],
            thumbnail: Constants.randomImage
        )
    }
}

// MARK: - Dimensions
struct Dimensions: Codable {
    let width: Double
    let height: Double
    let depth: Double

    enum CodingKeys: String, CodingKey {
        case width = "width"
        case height = "height"
        case depth = "depth"
    }
}

// MARK: - Meta
struct Meta: Codable {
    let createdAt: String
    let updatedAt: String
    let barcode: String
    let qrCode: String

    enum CodingKeys: String, CodingKey {
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case barcode = "barcode"
        case qrCode = "qrCode"
    }
}

// MARK: - Review
struct Review: Codable {
    let rating: Double
    let comment: String
    let date: String
    let reviewerName: String
    let reviewerEmail: String

    enum CodingKeys: String, CodingKey {
        case rating = "rating"
        case comment = "comment"
        case date = "date"
        case reviewerName = "reviewerName"
        case reviewerEmail = "reviewerEmail"
    }
}

struct ProductRow: Identifiable {
    let id = UUID().uuidString
    let title: String
    let product: [Product]
}
