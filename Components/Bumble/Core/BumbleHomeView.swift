//
//  BumbleHomeView.swift
//  Components
//
//  Created by beri on 21.09.2026.
//

/*
import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct BumbleHomeView: View {
    @Environment(\.router) var router
    @AppStorage("bumble_home_filter") private var selectedFilter = "Everyone"
    @State private var allUsers: [User] = []
    @State private var selectedIndex: Int = 0
    @State private var cardOffsets: [String: CGFloat] = [:] // Her kartın anlık X koordinatını tutar
    private let filters: [String] = ["Everyone", "Trending", "Hello"]
    @State private var currentSwipeoffset: CGFloat = 0
     
    var body: some View {
        ZStack {
            Color.bumbleWhite.ignoresSafeArea()

            VStack(spacing: 12) {
                header
                 
                BumbleFilterView(options: filters, selection: $selectedFilter)
                    .background(
                        Divider(), alignment: .bottom
                    )
             
                ZStack {
                    if !allUsers.isEmpty {
                        ForEach(Array(allUsers.enumerated()), id: \.element.id) { (index, user) in
                            let isPrevious = (selectedIndex - 1) == index
                            let isCurrent = selectedIndex == index
                            let isNext = (selectedIndex + 1) == index
                            
                            if isPrevious || isCurrent || isNext {
                                cardView(for: user, index: index)
                            }
                        }
                    } else {
                        ProgressView()
                    }
                     
                    overlaySwipingIndicator
                        .zIndex(999999)
                }
                .frame(maxHeight: .infinity)
            }
            .padding(8)
            .task {
                await getData()
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }
     
    private func userDidSelect(index: Int, isLike: Bool) {
        guard index < allUsers.count else { return }
        selectedIndex += 1
        currentSwipeoffset = 0
    }
      
    @ViewBuilder
    private func cardView(for user: User, index: Int) -> some View {
        let isCurrent = selectedIndex == index
          
        userProfileCell(for: user, index: index)
            .zIndex(Double(allUsers.count - index))
            .allowsHitTesting(isCurrent) // Sadece en üstteki kart tıklanabilir/sürüklenebilir olur
    }
      
    @ViewBuilder
    private func userProfileCell(for user: User, index: Int) -> some View {
        let userId = String(user.id)
        let xOffset = cardOffsets[userId] ?? 0
        let isCurrent = selectedIndex == index
          
        BumbleCardView(user: user)
            .offset(x: xOffset)
            .withDragGesture(
                .horizontal,
                resets: true, // Kendi otomatik sıfırlamasını kapatıp kontrolü tamamen aldık
                rotationMultiplier: 1.05,
                onChanged: { dragOffset in
                    guard isCurrent else { return }
                    currentSwipeoffset = dragOffset.width
                    cardOffsets[userId] = dragOffset.width
                },
                onEnded: { dragOffset in
                    guard isCurrent else { return }
                    currentSwipeoffset = 0
                   
                    withAnimation(.smooth) {
                        if dragOffset.width < -50 {
                            cardOffsets[userId] = -1000 // Sola uçur
                            userDidSelect(index: index, isLike: false)
                        } else if dragOffset.width > 50 {
                            cardOffsets[userId] = 1000  // Sağa uçur
                            userDidSelect(index: index, isLike: true)
                        } else {
                            cardOffsets[userId] = 0     // Yeterince çekmediyse yerine geri getir
                        }
                    }
                }
            )
    }
      
    private func getData() async {
        do {
            allUsers = try await DatabaseHelper().getUsers()
        } catch {
            print("Kullanıcılar çekilirken hata oluştu: \(error)")
            allUsers = [User.mock]
        }
    }
      
    private var header: some View {
        HStack(spacing: 0) {
            HStack(spacing: 12) {
                // Sol menü ikonuna tıklandığında Chats ekranına yönlendirir
                Image(systemName: "line.horizontal.3")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        router.showScreen(.push) { _ in
                            BumbleChatsView()
                        }
                    }
                 
                Image(systemName: "arrow.uturn.left")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        // Geri alma (Rewind) özelliği istenirse buraya eklenebilir
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
             
            Spacer()
             
            Text("bumble")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.bumbleYellow)
                .frame(maxWidth: .infinity, alignment: .leading)
             
            Spacer()
             
 Image(systemName*/
