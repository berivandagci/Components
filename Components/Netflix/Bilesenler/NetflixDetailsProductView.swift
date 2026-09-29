//
//  NetflixDetailsProductView.swift
//  Components
//
//  Created by beri on 29.09.2026.
//

import SwiftUI

struct NetflixDetailsProductView: View {
    var title: String = "Movie Title"
    var isNew: Bool = true
    var yearReleased: String = "2026"
    var seasonCount: Int? = 2
    var hasClosedCaptions: Bool = true
    var isTopTen: Int?  = 6
    var descriptionText : String = "SDFSDF FSDFSDF "
    var castText: String = "Cast: Berivan"
    var onPlayPressed: (() -> Void)? = nil
    var onDowloadPressed: (() -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 8) {
                if isNew {
                    Text("New")
                        .foregroundStyle(.green)
                }
                Text(yearReleased)
                if let seasonCount {
                    Text("\(seasonCount) Seasons")
                }
                if hasClosedCaptions {
                    Image(systemName: "captions.bubble")
                }
            }
            .foregroundStyle(.netflixLightGray)
            
            if let isTopTen {
                HStack(spacing: 8) {
                    Rectangle()
                        .fill(.netflixRed)
                        .frame(width: 28, height: 28)
                        .overlay(
                            VStack(spacing: 0) {
                                Text("TOP")
                                    .font(.system(size: 8))
                                Text("10") // Parantez kapatıldı
                                    .fontWeight(.bold)
                                    .font(.system(size: 16))
                                    .offset(y: 1)
                            }
                        )
                }
                .foregroundStyle(.netflixWhite) // Modifier doğru yere (HStack içine) taşındı
            }
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        NetflixDetailsProductView()
    }
}
