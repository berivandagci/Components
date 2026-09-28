//
//  NetflixMovieCell.swift
//  Components
//
//  Created by beri on 28.09.2026.
//

import SwiftUI

struct NetflixMovieCell: View {
    var width: CGFloat = 90
    var height: CGFloat = 160 // Yazım hatası düzeltildi
    var imageName: String? = Constants.randomImage
    var isRecentlyAdded: Bool = false
    var topTenRanking: Int? = nil
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            ImageLoaderView(urlString: imageName ?? Constants.randomImage)
                .cornerRadius(4)
            
            
            if let topTenRanking {
              
            }
        }
        .frame(width: width, height: height)
    }
}

#Preview {
    NetflixMovieCell()
}
