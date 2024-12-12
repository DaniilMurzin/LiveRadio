//
//  RadioPlayer.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 12.12.2024.
//

import Foundation
import AVFoundation

final class RadioPlayer: ObservableObject {
    
    @Published var avPlayer: AVPlayer?
    @Published var isPlaying: Bool = false
    
    func playStream(station: Station) {
        guard let url = URL(string: station.url) else {
            print("Ошибка: некорректный URL \(station.url)")
            return
        }

        let playerItem = AVPlayerItem(url: url)
        self.avPlayer = AVPlayer(playerItem: playerItem)
        self.avPlayer?.play()
        self.isPlaying = true
    }
    
    func stopStream(station: Station) {
        self.avPlayer?.pause()
        self.isPlaying = false
    }
}
