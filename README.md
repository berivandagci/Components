SwiftUI, SwiftData ve SwiftfulRouting kullanılarak geliştirilmiş, çevrimiçi müzik akışı ve çevrimdışı (offline) şarkı indirme/oynatma özelliklerine sahip iOS uygulaması.

## Özellikler

- **Çevrimdışı Şarkı İndirme:** Uzak URL üzerinden `.mp3` dosyalarını cihazın `Documents` dizinine indirir ve yerel dosya yolunu `SwiftData` ile saklar.
- **Akıllı Oynatma Önceliği:** Şarkı cihazda indirildiyse internet bağlantısı olmasa dahi yerel dosyadan, indirilmediyse uzak URL üzerinden oynatır.
- **İndirilenler Yönetimi:** İndirilen şarkıları listeleme, oynatma ve hem veritabanından (`SwiftData`) hem de cihaz depolamasından fiziksel olarak silme (`onDelete`) desteği.
- **Modüler Navigasyon:** `SwiftfulRouting` ve `SwiftfulUI` ile ekran geçişleri ve bileşen tabanlı mimari.

## Teknolojiler

- **Dil & Arayüz:** Swift, SwiftUI
- **Yerel Veritabanı:** SwiftData (`DownloadedSong` modeli)
- **Ses Oynatma:** AVFoundation (`AudioPlayerManager`)
- **Paketler:** `SwiftfulUI`, `SwiftfulRouting`, `SwiftfulRecursiveUI`

