//
//  NetflixMovieCell.swift
//  Components
//  Created by beri on 28.09.2026.
//

import SwiftUI

struct NetflixMovieCell: View {
    var width: CGFloat = 90
    var height: CGFloat = 160
    var imageName: String = Constants.randomImage
    var title: String? = "Movie Title"
    var isRecentlyAdded: Bool = false
    var topTenRanking: Int? = nil
    
    var body: some View {
        HStack(alignment: .bottom) {
            if let topTenRanking {
                Text("\(topTenRanking)")
                    .font(.system(size: 100, weight: .bold))
                    .foregroundColor(.netflixWhite)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .frame(width: 50)
                    .offset(x: 10, y: 10)
            }
            
            ZStack(alignment: .bottom) {
                ImageLoaderView(urlString: imageName)
                
                VStack(spacing: 8) {
                    if let title, let firstWord = title.components(separatedBy: " ").first {
                        Text(firstWord)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .lineLimit(1)
                    }
                    
                    if isRecentlyAdded {
                        Text("Recently Added")
                            .padding(.horizontal, 4)
                            .padding(.vertical, 2)
                            .frame(maxWidth: .infinity)
                            .background(Color.netflixRed)
                            .cornerRadius(2)
                            .lineLimit(1)
                            .font(.caption2)
                            .fontWeight(.bold)
                            .minimumScaleFactor(0.1)
                    }
                }
                .padding(8)
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(
                        colors: [
                            .netflixBlack.opacity(0),
                            .netflixBlack.opacity(0.3),
                            .netflixBlack.opacity(0.4),
                            .netflixBlack.opacity(0.8)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .cornerRadius(4)
            }
            .frame(width: width, height: height)
            .foregroundStyle(.netflixWhite)
            .cornerRadius(4)
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        VStack(spacing: 20) {
            NetflixMovieCell(topTenRanking: 3)
            NetflixMovieCell(isRecentlyAdded: true)
        }
    }
    .preferredColorScheme(.dark)
}
