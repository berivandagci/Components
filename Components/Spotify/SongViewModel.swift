import Foundation

@MainActor
class SongViewModel: ObservableObject {
    @Published var songs: [Song] = []
    @Published var isLoading: Bool = false
    
    private let databaseHelper = DatabaseHelper()
    
    func fetchSongs() {
        isLoading = true
        Task {
            do {
                self.songs = try await databaseHelper.getSongs()
                self.isLoading = false
            } catch {
                print("Şarkılar yüklenirken hata oluştu: \(error)")
                self.isLoading = false
            }
        }
    }
}
