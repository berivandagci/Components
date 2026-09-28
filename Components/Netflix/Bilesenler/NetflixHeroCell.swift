//
//  NetflixHeroCell.swift
//  Components
//
//  Created by beri on 28.09.2026.
//

import SwiftUI

struct NetflixHeroCell: View {
    var imageName: String = Constants.randomImage
    var isNetflixFilm: Bool = true
    var categories: [String] = ["Raunchy","Romantic", "Comedy"]
    var onBackgroundPressed: (() -> Void)? = nil
    var onPlayPressed: (() -> Void)? = nil

    var onMyListPressed: (() -> Void)? = nil

    var body: some View {
        ZStack {
            ImageLoaderView(urlString: imageName)
            VStack(spacing: 0) {
                if isNetflixFilm {
                    HStack(spacing: 8) {
                        Text("N")
                            .foregroundStyle(.netflixRed)
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
              
              
            }
            }
            .background(Color.red)
        }        .aspectRatio(0.8, contentMode: .fit)    }
}

#Preview {
    NetflixHeroCell()
        .padding(40)
}
