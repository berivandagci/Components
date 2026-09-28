//
//  NetflixHomeView.swift
//  Components
//
//  Created by beri on 24.09.2026.
//

import SwiftUI
import SwiftfulUI

struct NetflixHomeView: View {
    @State private var filters = FilterModel.mockArray
    @State private var selectedFilter: FilterModel? = nil
    @State private var fullHeaderSize: CGSize = .zero
    @State private var heroProduct: Product? = nil
    @State private var products: [Product] = []
    @State private var productRows: [ProductRow] = []
    @State private var currentUser: User? = nil
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.netflixBlack.ignoresSafeArea()
            
            mainScrollView
            headerGroup
        }
        .foregroundStyle(.netflixWhite)
        .task {
            await getData()
        }
    }
    
    private var mainScrollView: some View {
        ScrollView(.vertical) {
            VStack(spacing: 8) {
                Rectangle()
                    .opacity(0)
                    .frame(height: fullHeaderSize.height)
                
                heroCellSection
                productRowsSection
            }
        }
        .scrollIndicators(.hidden)
    }
    
    @ViewBuilder
    private var heroCellSection: some View {
        if let heroProduct {
            NetflixHeroCell(
                imageName: heroProduct.firstImage,
                isNetflixFilm: true,
                title: heroProduct.title,
                categories: heroCategories(product: heroProduct),
                onBackgroundPressed: {},
                onPlayPressed: {},
                onMyListPressed: {}
            )
            .padding(.horizontal, 8)
        }
        LazyVStack  (spacing: 16) {
            ForEach(productRows) { row in
                VStack(alignment: .leading, spacing: 6) {
                    Text(row.title)
                        .font(.headline)
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(row.products) { product in
                                NetflixMovieCell()
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
                
            }
        }
        ForEach(0..<20) { _ in
            Rectangle()
                .fill(Color.red)
                .frame(height: 200)
        }
    }
    
    private var productRowsSection: some View {
        ForEach(productRows) { row in
            VStack(alignment: .leading, spacing: 6) {
                Text(row.title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 24)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(row.product) { product in
                            NetflixMovieCell(
                                width: 120,
                                height: 160,
                                imageName: product.firstImage,
                                title: product.title,
                                isRecentlyAdded: false,
                                topTenRanking: nil
                            )
                        }
                    }
                    .padding(.horizontal, 24)
                }
            }
            .padding(.bottom, 24)
        }
    }
    
    private var headerGroup: some View {
        VStack(spacing: 8) {
            header
            NetflixFilterBarView(
                selectedFilter: $selectedFilter,
                onFilterPressed: {},
                onMarkPressed: {
                    selectedFilter = nil
                }
            )
            .padding(.horizontal, 16)
        }
        .background(Color.blue.opacity(0))
        .readingFrame { frame in
            fullHeaderSize = frame.size
        }
    }
    
    private var header: some View {
        HStack(spacing: 8) {
            Text("For You")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
            
            HStack(spacing: 16) {
                Image(systemName: "tv.badge.wifi").onTapGesture {}
                Image(systemName: "magnifyingglass").onTapGesture {}
            }
            .font(.title)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color.netflixBlack.opacity(0.8))
    }
    
    private func heroCategories(product: Product) -> [String] {
        var categories: [String] = []
        categories.append(product.category.capitalized)
        if let brand = product.brand {
            categories.append(brand)
        }
        return categories
    }
    
    private func getData() async {
        guard productRows.isEmpty else { return }
        
        do {
            currentUser = try? await DatabaseHelper().getUsers().first
            products = try await Array(DatabaseHelper().getProducts().prefix(8))
            heroProduct = products.first
            
            var newRows: [ProductRow] = []
            let allBrands = Set(products.compactMap({ $0.brand }))
            for brand in allBrands {
                let brandProducts = products.filter({ $0.brand == brand })
                newRows.append(ProductRow(title: brand.capitalized, product: brandProducts))
            }
            productRows = newRows
        } catch {
            print("Error getting data: \(error)")
        }
    }
}

#Preview {
    NetflixHomeView()
}
