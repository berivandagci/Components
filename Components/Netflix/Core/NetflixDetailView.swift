//
//  NetflixDetailView.swift
//  Components
//
//  Created by beri on 29.09.2026.
//

import SwiftUI

struct NetflixDetailView: View {
    var product: Product = .mock
    
    @State private var progress: Double = 0.2
    
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
                        
                    }
                )
                
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 16) {
                        NetflixDetailsProductView(
                            title: product.title,
                            isNew: true,
                            yearReleased: "2024",
                            seasonCount: 2,
                            hasClosedCaptions: true,
                            isTopTen: 6,
                            descriptionText: product.description,
                            castText: "Cast: Berivan",
                            onPlayPressed: {
                                
                            },
                            onDownloadPressed: {
                                
                            }
                        )
                    }
                    .padding(16)
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    NetflixDetailView()
}
