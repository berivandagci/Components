//
//  BumbleFilterView.swift
//  Components
//
//  Created by beri on 21.09.2026.
//
/*
import SwiftUI

struct BumbleFilterView: View {
    var options: [String] = ["Everyone", "Trending", "Hello"]
    @Binding var selection: String
    @Namespace private var namespace
    
    var body: some View {
        HStack {
            ForEach(options, id: \.self) { option in
                VStack {
                    Text(option)
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    if selection == option {
                        RoundedRectangle(cornerRadius: 2)
                            .frame(height: 1.5)
                            .matchedGeometryEffect(id: "selection", in: namespace)
                    }
                }
                .padding(.top, 8)
                .background(Color.black.opacity(0.001))
                .foregroundStyle(selection == option ? .bumbleBlack : .bumbleGray)
                .onTapGesture {
                    selection = option
                }
            }
        }
        .animation(.smooth, value: selection)
    }
}

fileprivate struct BumbleFilterViewPreview: View {
    var options: [String] = ["Everyone", "Trending", "Hello"]
    @State private var selection: String = "Hello"
    
    var body: some View {
        BumbleFilterView(selection: $selection)
            .padding()
    }
}

#Preview {
    BumbleFilterViewPreview()
}
 */
