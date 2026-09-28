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
    @State private var scrollOffset: CGFloat = 0
    
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
        ScrollViewWithOnScrollChanged(
            axes: .vertical,
            showsIndicators: false,
            onScrollChanged: { offset in
                scrollOffset = offset
            }
        ) {
            VStack(spacing: 8) {
                Rectangle()
                    .opacity(0)
                    .frame(height: fullHeaderSize.height)
                
                if let heroProduct {
                    heroCell(product: heroProduct)
                }
                
                categoryRows
            }
        }
    }
    
    private func heroCell(product: Product) -> some View {
        NetflixHeroCell(
            imageName: product.firstImage,
            isNetflixFilm: true,
            title: product.title,
            categories: heroCategories(product: product),
            onBackgroundPressed: {},
            onPlayPressed: {},
            onMyListPressed: {}
        )
        .padding(.horizontal, 8)
    }
    
    private var categoryRows: some View {
        LazyVStack(spacing: 16) {
            ForEach(Array(productRows.enumerated()), id: \.offset) { (rowIndex, row) in
                VStack(alignment: .leading, spacing: 6) {
                    Text(row.title)
                        .font(.headline)
                        .padding(.horizontal, 16)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(Array(row.product.enumerated()), id: \.offset) { (index, product) in
                                NetflixMovieCell(
                                    imageName: product.firstImage,
                                    title: product.title,
                                    isRecentlyAdded: product.isRecentlyAdded,
                                    topTenRanking: rowIndex == 1 ? (index + 1) : nil
                                )
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
            }
        }
    }
    
    private var headerGroup: some View {
        VStack(spacing: 8) {
            header
            
            NetflixFilterBarView(
                filters: filters,
                selectedFilter: $selectedFilter,
                onFilterPressed: { newFilter in
                    selectedFilter = newFilter
                },
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
