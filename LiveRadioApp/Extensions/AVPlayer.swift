//
//  AVPlayer + IsPlaying.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 04.01.2025.
//

import AVFoundation

extension AVPlayer {
    var isPlaying: Bool { rate > .zero && error == nil }
}

extension AVPlayerItem {
    static func parse(station: Station) -> AVPlayerItem? {
        URL(string: station.url).map(AVPlayerItem.init)
    }
}
