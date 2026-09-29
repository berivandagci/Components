//
//  NetflixDetailsHeaderView.swift
//  Components
//
//  Created by beri on 29.09.2026.
//

import SwiftUI

struct NetflixDetailsHeaderView: View {
    var imageName: String = Constants.randomImage
    var progress: Double = 0.2
    var onAirplayPressed: (() -> Void)? = nil
    var onXMarkPressed: (() -> Void)? = nil
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ImageLoaderView(urlString: imageName)
            
           
            VStack {
                HStack {
                    Spacer()
                    
                    HStack(spacing: 16) {
                        if let onAirplayPressed {
                            Button(action: onAirplayPressed) {
                                Image(systemName: "airplayvideo")
                                    .font(.title2)
                                    .foregroundStyle(.white)
                            }
                        }
                        
                        if let onXMarkPressed {
                            Button(action: onXMarkPressed) {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.title2)
                                    .foregroundStyle(.white)
                                    .background(Color.black.opacity(0.5))
                                    .clipShape(Circle())
                            }
                        }
                    }
                }
                .padding(16)
                
                Spacer()
            }
            
            // Alt kısımdaki İlerleme Çubuğu (Progress Bar)
            CustomProgressBar(
                selection: Binding.constant(progress),
                range: 0...1,
                backgroundColor: Color.gray.opacity(0.5),
                foregroundColor: Color.netflixRed
            )
            .frame(height: 4)
            .padding(.horizontal, 0)
        }
        .aspectRatio(16/9, contentMode: .fit)
    }
}

#Preview {
    NetflixDetailsHeaderView()
}
