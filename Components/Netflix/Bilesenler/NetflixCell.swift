//
//  NetflixCell.swift
//  Components
//
//  Created by beri on 24.09.2026.
//
/*import SwiftUI

struct NetflixCell: View {
    var title: String = "Categories"
    var isDropDown: Bool = true
    var isSelected: Bool = false
    var body: some View {
        HStack(spacing: 4) {
            Text(title)
            
            if isDropDown {
                Image(systemName: "chevron.down")
            }
        }
        .padding(.horizontal,16)
        .padding(.vertical, 8)
        .background(
            ZStack {
                Capsule(style: .circular)
                 .fill(.netflixDarkGray)
                 .opacity(isSelected ? 1 : 0)
                if isSelected {
            
                
                Capsule(style: .circular)
                    .stroke(lineWidth: 1)
            }
            }
        )
        .foregroundStyle(.netflixLightGray)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack {
            NetflixCell()
            NetflixCell(isSelected: true)
            NetflixCell(isDropDown: false)


        }
    }
    
}
*/
