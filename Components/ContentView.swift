//
//  ContentView.swift
//  Components
//
//  Created by beri on 10.09.2026.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting
import SwiftfulRecursiveUI

struct ContentView: View {
    @Environment(\.router) var router
    
    var body: some View {
        List {
            Button("OPEN Spotify") {
                router.showScreen(.fullScreenCover) { _ in
                    SpotifyHomeView(viewModel: SpotifyHomeViewModel(router: router))
                }
            }
            
            Button("Open Bumble") {
                router.showScreen(.fullScreenCover) { _ in
                    BumbleHomeView()
                }
            }
            Button("Open Netflix") {
                router.showScreen(.fullScreenCover) { _ in
                    NetflixHomeView()
                }
            }
        }
    }
}

#Preview {
    RouterView { _ in
        ContentView()
    }
}
