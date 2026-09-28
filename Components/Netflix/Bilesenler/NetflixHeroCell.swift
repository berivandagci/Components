//
//  NetflixHeroCell.swift
//  Components
//
//  Created by beri on 28.09.2026.
//

import SwiftUI
import SwiftfulUI

struct NetflixHeroCell: View {
    // MARK: - Properties (Özellikler ve Parametreler)
    var imageName: String = Constants.randomImage
    var isNetflixFilm: Bool = true
    var title: String = "Shrek"
    var categories: [String] = ["Raunchy", "Romantic", "Comedy"]
    
    // MARK: - Actions (Buton ve Tıklama Olayları)
    var onBackgroundPressed: (() -> Void)? = nil
    var onPlayPressed: (() -> Void)? = nil
    var onMyListPressed: (() -> Void)? = nil

    var body: some View {
        ZStack(alignment: .bottom) {
            // Arka plan görseli
            ImageLoaderView(urlString: imageName)
            
            // İçerik Konteyneri
            VStack(spacing: 16) {
                VStack(spacing: 0) {
                    // Netflix Orijinal İçerik Logosu ve Etiketi
                    if isNetflixFilm {
                        HStack(spacing: 8) {
                            Text("N")
                                .foregroundStyle(.netflixRed)
                                .font(.largeTitle)
                                .fontWeight(.black)
                            
                            Text("FILM")
                                .kerning(3)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.netflixLightGray)
                        }
                    }
                    
                    // İçerik Başlığı (Serif Tasarım)
                    Text(title)
                        .font(.system(size: 80, weight: .medium, design: .serif))
                }
                
                // Kategoriler Listesi
                HStack(spacing: 8) {
                    ForEach(categories, id: \.self) { category in
                        Text(category)
                            .font(.callout)
                        
                        // Son eleman değilse araya nokta koy
                        if category != categories.last {
                            Circle()
                                .frame(width: 4, height: 4)
                        }
                    }
                }
                
                // Butonlar (Play & My List)
                HStack(spacing: 8) {
                    // Play Butonu
                    HStack {
                        Image(systemName: "play.fill")
                        Text("Play") // Büyük harfe çevrildi
                    }
                    .frame(maxWidth: .infinity) // Düzeltildi: minWidth yerine maxWidth
                    .padding(.vertical, 8)
                    .foregroundStyle(.netflixDarkGray)
                    .background(.netflixWhite)
                    .cornerRadius(4)
                    .asButton(.press) {
                        onPlayPressed?()
                    }
                    
                    // My List Butonu
                    HStack {
                        Image(systemName: "plus")
                        Text("My List")
                    }
                    .frame(maxWidth: .infinity) // Düzeltildi: minWidth yerine maxWidth
                    .padding(.vertical, 8)
                    .foregroundStyle(.netflixWhite)
                    .background(.netflixDarkGray)
                    .cornerRadius(4)
                    .asButton(.press) {
                        onMyListPressed?() // Düzeltildi: Doğru action bağlandı
                    }
                }
                .font(.callout)
                .fontWeight(.medium)
            }
            .background(Color.blue) // Test amaçlı rengi görebilirsin
            .padding(24)
        }
        .padding(24)
        .aspectRatio(0.8, contentMode: .fit)
    }
}

// MARK: - Preview (Önizleme)
#Preview {
    NetflixHeroCell()
        .padding(40)
}
