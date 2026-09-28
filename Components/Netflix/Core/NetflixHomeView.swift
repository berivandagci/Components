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
            
            ScrollView(.vertical) {
                VStack(spacing: 8) {
           
                    Rectangle()
                        .opacity(0)
                        .frame(height: fullHeaderSize.height)
                    
                    if let heroProduct {
                        NetflixHeroCell(
                            imageName: heroProduct.firstImage,
                            isNetflixFilm: true,
                            title: heroProduct.title,
                            categories: [heroProduct.category.capitalized, heroProduct.brand].compactMap({ $0 }),
                            onBackgroundPressed: {
                               
                            },
                            onPlayPressed: {
                              
                            },
                            onMyListPressed: {
                            
                            }
                        )
                        .padding(.horizontal, 8)
                    }
                    
                    ForEach(productRows, id: \.self) { row in
                        VStack(alignment: .leading, spacing: 6) {
                            Text(row.title)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 24)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(row.products) { product in
                                        Text(product.title)
                                            .frame(width: 120, height: 160)
                                            .background(Color.gray.opacity(0.3))
                                            .cornerRadius(8)
                                    }
                                }
                                .padding(.horizontal, 24)
                            }
                        }
                        .padding(.bottom, 24)
                    }
                }
            }
            .scrollIndicators(.hidden)
            
            VStack(spacing: 8) {
                header
                NetflixFilterBarView(
                    selectedFilter: $selectedFilter,
                    onFilterPressed: {
                     
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
        .foregroundStyle(.netflixWhite)
        .task {
            await getData()
        }
    }
    
    private var header: some View {
        HStack(spacing: 8) {
            Text("For You")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
            
            HStack(spacing: 16) {
                Image(systemName: "tv.badge.wifi")
                    .onTapGesture {
                        
                    }
                
                Image(systemName: "magnifyingglass")
                    .onTapGesture {
                        
                    }
            }
            .font(.title)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color.netflixBlack.opacity(0.8))
    }
    
    private func getData() async {
        guard productRows.isEmpty else { return }
        
        do {
            currentUser = try? await DatabaseHelper().getUsers().first
            products = try await Array(DatabaseHelper().getProducts().prefix(8))
            heroProduct = products.first
            
            var newRows: [ProductRow] = []
            let allBrands = Set(products.map({ $0.brand }))
            for brand in allBrands {
                guard let brand = brand else { continue }
                let brandProducts = products.filter({ $0.brand == brand })
            
                newRows.append(ProductRow(title: brand.capitalized, products: brandProducts))
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
