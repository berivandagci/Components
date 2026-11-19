//
//  AudioPlayerManager.swift
//  Components
//
//  Created by beri on 19.11.2026.
//

import Foundation
import AVFoundation
import Observation

@Observable
final class AudioPlayerManager {
    static let shared = AudioPlayerManager()
    private init() {}
    
    private var player: AVPlayer?
    var currentURL: URL? = nil
    var isPlaying = false
    
    func play(url: URL) {
        // Sessiz modda da ses çıksın
        try? AVAudioSession.sharedInstance().setCategory(.playback)
        try? AVAudioSession.sharedInstance().setActive(true)
        
        // Aynı şarkı duraklatılmışsa kaldığı yerden devam et
        if currentURL == url, let player {
            player.play()
            isPlaying = true
            return
        }
        
        player = AVPlayer(url: url)
        currentURL = url
        player?.play()
        isPlaying = true
    }
    
    func pause() {
        player?.pause()
        isPlaying = false
    }
    
    func stop() {
        player?.pause()
        player = nil
        currentURL = nil
        isPlaying = false
    }
}
