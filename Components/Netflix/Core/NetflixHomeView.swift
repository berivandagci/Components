//
//  NetflixHomeView.swift
//  Components
//
//  Created by beri on 24.09.2026.
//

import SwiftUI

struct NetflixHomeView: View {
    @State private var filters = FilterModel.mockArray
    @State private var selectedFilter: FilterModel? = nil
    var body: some View {
        ZStack {
            Color.netflixBlack.ignoresSafeArea()
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    NetflixHeroCell()
                    ForEach(0..<20) { _ in
                        Rectangle()
                            .fill(Color.red)
                            .frame(height: 200)
                    }
                }
            }
            .scrollIndicators(.hidden)
            VStack(spacing: 8) {
                header
                NetflixFilterBarView(
                    selectedFilter: $selectedFilter, // Binding ($) ile bağlandı
                    onFilterPressed: {
                        // Filtreye tıklandığında yapılacaklar
                    },
                    onMarkPressed: {
                        selectedFilter = nil
                    }
                )
                    .padding(.horizontal, 16)
                Spacer()
            }
            
        }
        .foregroundStyle(.netflixWhite)
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
    }
}

#Preview {
    NetflixHomeView()
}
