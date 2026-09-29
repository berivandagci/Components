//
//  NetflixDetailsProductView.swift
//  Components
//
//  Created by beri on 29.09.2026.
//

import SwiftUI
import SwiftfulUI

struct NetflixDetailsProductView: View {
    var title: String = "Movie Title"
    var isNew: Bool = true
    var yearReleased: String = "2026"
    var seasonCount: Int? = 2
    var hasClosedCaptions: Bool = true
    var isTopTen: Int?  = 6
    var descriptionText : String? = "SDFSDF FSDFSDF "
    var castText: String? = "Cast: Berivan"
    var onPlayPressed: (() -> Void)? = nil
    var onDownloadPressed: (() -> Void)? = nil
    
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
                    topTenIcon
                    Text("#\(isTopTen) in TV Shows Today")
                        .font(.headline)
                }
            }
            
            VStack(spacing: 8) {
                HStack {
                    Image(systemName: "play.fill")
                    Text("Play")
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .foregroundStyle(.netflixDarkGray)
                .background(.netflixWhite)
                .cornerRadius(4)
                .asButton(.press) {
                    onPlayPressed?()
                }
                
                HStack {
                    Image(systemName: "arrow.down.to.line.alt")
                    Text("Download")
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .foregroundStyle(.netflixWhite)
                .background(.netflixDarkGray)
                .cornerRadius(4)
                .asButton(.press) {
                    onDownloadPressed?()
                }
            }
            .font(.callout)
            .fontWeight(.medium)
            
            if let descriptionText {
                Text(descriptionText)
            }
            
            if let castText {
                Text(castText)
                    .foregroundStyle(.netflixLightGray)
            }
        }
        .font(.callout)
        .frame(maxWidth: .infinity, alignment: .leading)
        .multilineTextAlignment(.leading)
        .foregroundStyle(.netflixWhite) // Doğru yere ve düzeltilmiş isimle taşındı
    }
    
    private var topTenIcon: some View {
        HStack(spacing: 8) {
            Rectangle()
                .fill(.netflixRed)
                .frame(width: 28, height: 28)
                .overlay(
                    VStack(spacing: 0) {
                        Text("TOP")
                            .font(.system(size: 8))
                        Text("10")
                            .fontWeight(.bold)
                            .font(.system(size: 16))
                            .offset(y: 1)
                    }
                )
        }
        .foregroundStyle(.netflixWhite)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack {
        NetflixDetailsProductView()
        NetflixDetailsProductView(isTopTen: nil)
NetflixDetailsProductView()
    }
    }
}
