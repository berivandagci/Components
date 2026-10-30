//
//  BumbleChatsView.swift
//  Components
//
//  Created by beri on 23.09.2026.
//

/*
import SwiftUI
import SwiftfulRouting

struct BumbleChatsView: View {
    @Environment(\.router) var router
    @State private var allUsers: [User] = []

    var body: some View {
        ZStack {
            Color.bumbleWhite.ignoresSafeArea()
             
            VStack(spacing: 0) {
                header
                    .padding(16)
                 
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        matchQueueSection
                        chatsSection
                    }
                }
            }
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
     
    // MARK: - Header
    private var header: some View {
        HStack(spacing: 0) {
            Image(systemName: "line.horizontal.3")
                .padding(8)
                .background(Color.black.opacity(0.001))
                .onTapGesture {
                    router.dismissScreen()
                }
             
            Spacer(minLength: 0)
             
            Image(systemName: "magnifyingglass")
                .padding(8)
                .background(Color.black.opacity(0.001))
                .onTapGesture {
                    // Arama aksiyonu buraya eklenebilir
                }
        }
        .font(.title)
        .fontWeight(.medium)
        .foregroundStyle(.bumbleBlack)
    }

    // MARK: - Match Queue Section
    private var matchQueueSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 4) {
                Text("Match Queue")
                Text("(\(allUsers.count))")
                    .foregroundStyle(.bumbleGray)
            }
            .font(.headline)
            .padding(.horizontal, 16)
             
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(allUsers) { user in
                        VStack(spacing: 4) {
                            BumbleProfileImageCell(
                                imageName: user.image,
                                percentageRemaining: Double.random(in: 0...1),
                                hasNewMessage: Bool.random()
                            )
                            .onTapGesture {
                                // Match queue içindeki profile tıklama aksiyonu
                            }
                             
                            Text(user.firstName)
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundStyle(.bumbleBlack)
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }

    // MARK: - Chats Section (Bumble Chat Listesi)
    private var chatsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Conversations")
                .font(.headline)
                .foregroundStyle(.bumbleBlack)
                .padding(.horizontal, 16)
             
            LazyVStack(spacing: 12) {
                ForEach(allUsers) { user in
                    HStack(spacing: 12) {
                        // Profil Resmi
                        BumbleProfileImageCell(
                            imageName: user.image,
                            percentageRemaining: 0,
                            hasNewMessage: false
                        )
                        .frame(width: 65, height: 65)
                         
                        // İsim ve Son Mesaj
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.firstName)
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundStyle(.bumbleBlack)
                             
                            Text("Send a message or reply to their profile...")
                                .font(.footnote)
                                .foregroundStyle(.bumbleGray)
                                .lineLimit(1)
                        }
                         
                        Spacer()
                         
                        // Zaman / Bildirim İkonalanı
                        Text("12:45")
                            .font(.caption2)
                            .foregroundStyle(.bumbleGray)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 4)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        
                    }
                }
            }
        }
    }

    // MARK: - Data Fetching
    private func getData() async {
        guard allUsers.isEmpty else { return }
        do {
            allUsers = try await DatabaseHelper().getUsers()
        } catch {
            print("Kullanıcılar yüklenirken hata oluştu: \(error)")
            allUsers = [User.mock]
        }
    }
}

#Preview {
    RouterView { _ in
        BumbleChatsView()
    }
}
*/
