//
//  BumbleChatPreviewCell.swift
//  Components
//
//  Created by beri on 22.09.2026.
//
/*
import SwiftUI

struct BumbleChatPreviewCell: View {
    var imageName : String  = Constants.randomImage
    var percentageRemaining: Double = Double.random(in: 0...1)
    var hasNewMessage: Bool = true
    var userName: String = "Berivan"
    var lastChatMessage: String? = "This is the last message sdfsdf fdsfsdfsdfs sfsdfsdfs fsdfsdfsd "
    var isYourMove: Bool = true
    
    var body: some View {
     
        HStack(spacing: 12) {
            BumbleProfileImageCell(imageName: imageName,
                                   percentageRemaining: percentageRemaining,
                                   hasNewMessage: hasNewMessage)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 0) {
                    Text(userName)
                        .font(.headline)
                        .foregroundStyle(.bumbleBlack)
                        .frame(maxWidth: .infinity, alignment: .leading)
                     
                    if isYourMove {
                        Text("Your Move")
                            .font(.caption2)
                            .bold()
                            .padding(.vertical, 4)
                            .padding(.horizontal ,6)
                            .background(.bumbleYellow)
                            .cornerRadius(32)
                    }
                }
                
                if let lastChatMessage {
                    Text(lastChatMessage)
                        .font(.subheadline)
                        .foregroundStyle(.bumbleGray)
                        .lineLimit(1)
                        .padding(.trailing, 16)
                }
            }
        }
    }
}

#Preview {
    BumbleChatPreviewCell()
        .padding()
}
*/
