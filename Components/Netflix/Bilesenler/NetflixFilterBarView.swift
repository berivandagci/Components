//
//  NetflixFilterBarView.swift
//  Components
//
//  Created by beri on 24.09.2026.
//
/*
import SwiftUI

struct FilterModel: Hashable, Equatable {
    let title: String
    let isDropdown: Bool
    
    static var mockArray: [FilterModel] {
        [
            FilterModel(title: "Categories", isDropdown: true),
            FilterModel(title: "TV Shows", isDropdown: false),
            FilterModel(title: "Movies", isDropdown: false)
        ]
    }
}

struct NetflixFilterBarView: View {
    // Senin istediğin gibi dışarıdan yönetilebilmesi için @Binding yaptık
    @Binding var selectedFilter: FilterModel?
    
    var filters: [FilterModel] = FilterModel.mockArray
    var onFilterPressed: (() -> Void)? = nil
    var onMarkPressed: (() -> Void)? = nil
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                if selectedFilter != nil {
                    Image(systemName: "xmark")
                        .padding(8)
                        .background(
                            Circle()
                                .stroke(lineWidth: 1)
                        )
                        .foregroundStyle(.netflixLightGray)
                        .background(Color.black.opacity(0.001))
                        .onTapGesture {
                            onMarkPressed?()
                            selectedFilter = nil
                        }
                        .transition(AnyTransition.move(edge: .leading))
                        .padding(.leading, 16)
                }
                
                ForEach(filters, id: \.self) { filter in
                    if selectedFilter == nil || selectedFilter == filter {
                        NetflixCell(
                            title: filter.title,
                            isDropDown: filter.isDropdown,
                            isSelected: selectedFilter == filter
                        )
                        .background(Color.black.opacity(0.001))
                        .onTapGesture {
                            onFilterPressed?()
                            selectedFilter = filter
                        }
                        .padding(.leading, (selectedFilter == nil && filter == filters.first) ? 16 : 0)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .padding(.vertical, 4)
        .animation(.bouncy, value: selectedFilter)
    }
}

// Senin kurduğun özel Preview sarmalayıcısı (yerinde duruyor)
fileprivate struct NetflixFilterBarViewPreview: View {
    @State private var filters = FilterModel.mockArray
    @State private var selectedFilter: FilterModel? = nil
    
    var body: some View {
        NetflixFilterBarView(
            selectedFilter: $selectedFilter, // Binding ($) ile bağlandı
            onFilterPressed: {
                // Filtreye tıklandığında yapılacaklar
            },
            onMarkPressed: {
                selectedFilter = nil
            }
        )
    }
}

#Preview {
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        NetflixFilterBarViewPreview()
    }
}
 */
