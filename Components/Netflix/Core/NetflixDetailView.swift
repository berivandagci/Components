//
//  NetflixDetailView.swift
//  Components
//
//  Created by beri on 29.09.2026.
//

import SwiftUI
import SwiftfulRouting

struct NetflixDetailView: View {
    
    @Environment(\.router) var router

    var product: Product = .mock
    
    @State private var progress: Double = 0.2
    @State private var isMyList: Bool = false
    @State private var products: [Product] = []
    
    var body: some View {
        ZStack {
            Color.netflixBlack.ignoresSafeArea()
            Color.netflixDarkGray.opacity(0.3).ignoresSafeArea()
            
            VStack(spacing: 0) {
                NetflixDetailsHeaderView(
                    imageName: product.firstImage,
                    progress: progress,
                    onAirplayPressed: {
                        
                    },
                    onXMarkPressed: {
                        router.dismissScreen()
                    }
                )
                
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 16) {
                        detailsProductSection
                        buttonsSection
                        productsGridSection
                    }
                    .padding(8)
                }
                .scrollIndicators(.hidden)
            }
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private func getData() async {
        guard products.isEmpty else { return }
        
        do {
            products = try await DatabaseHelper().getProducts()
        } catch {
            
        }
    }
    
    private var detailsProductSection: some View {
        NetflixDetailsProductView(
            title: product.title,
            isNew: true,
            yearReleased: "2024",
            seasonCount: 4,
            hasClosedCaptions: true,
            isTopTen: 6,
            descriptionText: product.description,
            castText: "Cast: Nick, Your Name, Someone Else",
            onPlayPressed: {
                
            },
            onDownloadPressed: {
                
            }
        )
    }
    
    private func onProductPressed(product: Product) {
        router.showScreen(.sheet) { _ in
            NetflixDetailView(product: product)
        }
    }
    
    private var buttonsSection: some View {
        HStack(spacing: 32) {
            MyListButton(isMyList: isMyList) {
                isMyList.toggle()
            }
            
            RateButton { selection in
                // do something with selection
            }
            
            ShareButton()
        }
        .padding(.leading, 32)
    }
    
    private var productsGridSection: some View {
        VStack(alignment: .leading) {
            Text("More Like This")
                .font(.headline)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 3),
                      alignment: .center,
                      spacing: 8,
                      pinnedViews: [],
                      content: {
                ForEach(products) { item in
                    NetflixMovieCell(
                        imageName: item.firstImage,
                        title: item.title,
                        isRecentlyAdded: false,
                        topTenRanking: nil
                    )
                    .onTapGesture {
                        onProductPressed(product: item)
                    }
                }
            })
        }
        .foregroundStyle(.netflixWhite)
    }
}

#Preview {
    RouterView { _ in
        NetflixDetailView()
    }
}
