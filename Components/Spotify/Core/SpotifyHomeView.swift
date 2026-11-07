//
//  SpotifyHomeView.swift
//  Components
//
//  Created by beri on 10.09.2026.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

@Observable
final class SpotifyHomeViewModel {
    let router: AnyRouter?
    var currentUser: User? = nil
    var selectedCategory: SpotifyCategory? = nil
    var songs: [Song] = []
    var songRows: [SongRow] = []

    init(router: AnyRouter? = nil) {
        self.router = router
    }

    func getData() async {
        do {
            currentUser = try await DatabaseHelper().getUsers().first
        } catch {
            print("Kullanıcı çekilirken hata oluştu: \(error)")
            currentUser = .mock
        }
        
        do {
            let allSongs = try await DatabaseHelper().getSongs()
            songs = Array(allSongs.prefix(8))
            
            var rows: [SongRow] = []
            let allArtists = Set(songs.map({ $0.artist }))
            for artist in allArtists {
                let filteredSongs = songs.filter({ $0.artist == artist })
                rows.append(SongRow(
                    title: artist?.capitalized ?? "Diğer",
                    songs: filteredSongs
                ))
            }
            songRows = rows
        } catch {
            let nsError = error as NSError
            if nsError.domain == NSURLErrorDomain && nsError.code == -999 {
                return
            }
            print("Şarkılar çekilirken hata oluştu: \(error)")
        }
    }
}

struct SpotifyHomeView: View {
    @Environment(\.router) var router
    @State private var viewModel: SpotifyHomeViewModel

    init(viewModel: SpotifyHomeViewModel = SpotifyHomeViewModel()) {
        self._viewModel = State(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 1, pinnedViews: [.sectionHeaders]) {
                    Section {
                        VStack(spacing: 24) {
                            recentsSection
                            
                            if let song = viewModel.songs.first {
                                newReleasedSection(song: song)
                            }
                            
                            listRows
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                        
                        ForEach(0..<20, id: \.self) { _ in
                            Rectangle()
                                .fill(.spotifyDarkGray)
                                .frame(width: 200, height: 200)
                        }
                    } header: {
                        header
                    }
                }
            }
            .scrollIndicators(.hidden)
            .clipped()
        }
        .task {
            await viewModel.getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var header: some View {
        VStack(spacing: 20) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    if let currentUser = viewModel.currentUser {
                        ImageLoaderView(urlString: currentUser.image)
                            .frame(width: 30, height: 30)
                            .background(.spotifyWhite)
                            .clipShape(Circle())
                            .onTapGesture {
                                let activeRouter = viewModel.router ?? router
                                activeRouter.dismissScreen()
                            }
                    }
                    
                    ForEach(SpotifyCategory.allCases, id: \.self) { category in
                        SpotifyCategoryCell(
                            title: category.rawValue.capitalized,
                            isSelection: category == viewModel.selectedCategory
                        )
                        .onTapGesture {
                            viewModel.selectedCategory = category
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
        }
        .padding(.vertical, 8)
        .background(Color.spotifyBlack)
    }
    
    private var recentsSection: some View {
        NonLazyVGrid(columns: 2, alignment: .center, spacing: 10, items: viewModel.songs) { song in
            if let song {
                SpotifyRecentlyCell(
                    imageName: song.firstImage,
                    title: song.title ?? ""
                )
                .asButton(.press) {
                    goToPlaylistView(song: song)
                }
            }
        }
    }
    
    private func goToPlaylistView(song: Song) {
        let userToPass = viewModel.currentUser ?? .mock
        let activeRouter = viewModel.router ?? router
        let allSongs = viewModel.songs
         
        activeRouter.showScreen(.push) { _ in
            SpotifyPlayListView(song: song, songs: allSongs, user: userToPass)
        }
    }
    
    private func newReleasedSection(song: Song) -> some View {
        SpotifyReleaseCell(
            imageName: song.firstImage,
            headline: "Yeni çıkan",
            subheadline: song.artist,
            title: song.title,
            subtitle: nil,
            onAddToPlaylistPressed: {
                
            },
            onPlayPressed: {
                goToPlaylistView(song: song)
            }
        )
        .asButton(.press) {
            goToPlaylistView(song: song)
        }
    }
    
    private var listRows: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(viewModel.songRows, id: \.title) { row in
                    VStack(alignment: .leading, spacing: 12) {
                        Text(row.title)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.spotifyWhite)
                        
                        VStack(spacing: 12) {
                            ForEach(row.songs) { song in
                                ImageTitleRowCell(
                                    imageSize: 120,
                                    imageName: song.firstImage,
                                    title: song.title ?? ""
                                )
                                .asButton(.press) {
                                    goToPlaylistView(song: song)
                                }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    RouterView { router in
        SpotifyHomeView(viewModel: SpotifyHomeViewModel(router: router))
    }
}
