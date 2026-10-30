import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct SpotifyPlayListView: View {
    var product: Product = .mock
    var user: User = .mock
    @Environment(\.router) var router
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    headerImage
                    
                    PlaylistDescriptionCell(
                        descriptionText: product.description,
                        userName: user.firstName,
                        subheadline: product.brand ?? "",
                        onAddToPlaylistPressed: {},
                        onSharedPressed: {},
                        onDownLoadPressed: {},
                        onEllipsisPressed: {},
                        onShufflePressed: {},
                        onPlayPressed: {}
                    )
                    .padding(16)
                    
                    VStack(spacing: 12) {
                        ForEach(1..<15, id: \.self) { _ in
                            HStack(spacing: 12) {
                                Rectangle()
                                    .fill(Color.spotifyDarkGray)
                                    .frame(width: 50, height: 50)
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(product.title)
                                        .font(.body)
                                        .bold()
                                        .foregroundStyle(.spotifyWhite)
                                    Text(product.brand ?? "Sanatçı")
                                        .font(.caption)
                                        .foregroundStyle(.spotifyLightGray)
                                }
                                Spacer()
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    private var headerImage: some View {
        Rectangle()
            .fill(Color.spotifyDarkGray)
            .aspectRatio(1, contentMode: .fit)
            .overlay(
                ImageLoaderView(urlString: product.firstImage)
            )
    }
}

#Preview {
    RouterView { router in
        SpotifyPlayListView(product: .mock, user: .mock)
    }
}
