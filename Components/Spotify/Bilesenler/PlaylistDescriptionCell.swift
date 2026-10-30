import SwiftUI

struct PlaylistDescriptionCell: View {
    var descriptionText: String = Product.mock.description
    var userName: String = "Berivan"
    var subheadline: String = "Some headline goes here"
    var onAddToPlaylistPressed: (() -> Void)? = nil
    var onSharedPressed: (() -> Void)? = nil
    var onDownLoadPressed: (() -> Void)? = nil
    var onEllipsisPressed: (() -> Void)? = nil
    var onShufflePressed: (() -> Void)? = nil
    var onPlayPressed: (() -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(descriptionText)
                .foregroundStyle(.spotifyLightGray)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            madeForYouSection
            
            Text(subheadline)
            buttonsRow
        }
        .font(.callout)
        .fontWeight(.medium)
        .foregroundStyle(.spotifyLightGray)
    }
    
    private var madeForYouSection: some View {
        HStack(spacing: 8) {
            Image(systemName: "applelogo")
                .font(.title3)
                .foregroundStyle(.spotifyGreen)
            Text("Made for")
            Text(userName)
                .bold()
                .foregroundStyle(.spotifyWhite)
        }
    }
    
    private var buttonsRow: some View {
        HStack(spacing: 0) {
            HStack(spacing: 20) {
                Image(systemName: "plus.circle")
                    .font(.title2)
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        onAddToPlaylistPressed?()
                    }
                
                Image(systemName: "arrow.down.circle")
                    .font(.title2)
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        onDownLoadPressed?()
                    }
                
                Image(systemName: "square.and.arrow.up")
                    .font(.title3)
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        onSharedPressed?()
                    }
                
                Image(systemName: "ellipsis")
                    .font(.title3)
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        onEllipsisPressed?()
                    }
            }
            
            Spacer()
            
            HStack(spacing: 16) {
                Image(systemName: "shuffle")
                    .font(.title2)
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        onShufflePressed?()
                    }
                
                Image(systemName: "play.circle.fill")
                    .font(.system(size: 50))
                    .foregroundStyle(.spotifyGreen)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        onPlayPressed?()
                    }
            }
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        PlaylistDescriptionCell()
            .padding()
    }
}
