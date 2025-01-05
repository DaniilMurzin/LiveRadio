//
//  RadioPlayer.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 12.12.2024.
//

import Foundation
import AVFoundation

final class RadioPlayer: ObservableObject {
    typealias PlayerDeck = Zipper<Station>
    
    //MARK: - Properties
    @Published private var avPlayer: AVPlayer?
    @Published private var playerDeck: PlayerDeck?
    @Published var volume: Double = 0.5 {
        didSet {
            avPlayer?.volume = Float(volume)
        }
    }
    
    var currentStation: Station? { playerDeck?.current }
    var isPlaying: Bool {
        get { avPlayer?.isPlaying ?? false }
        set { avPlayer?.rate = newValue ? 1 : 0 }
    }
    
    //MARK: - Methods
    @discardableResult
    func play(stations: [Station], selected: (Station) -> Bool) -> Bool {
        playerDeck = PlayerDeck(stations)
        playerDeck?.move(to: selected)
        return playerDeck?.current.map(playStation) ?? false
    }
    
    @discardableResult
    func play(where predicate: (Station) -> Bool) -> Bool {
        playerDeck?.move(to: predicate)
        return playerDeck?.current.map(playStation) ?? false
    }
    
    func setStations(_ stations: [Station]) {
        playerDeck = PlayerDeck(stations)
    }
    
    @discardableResult
    func playNext() -> Bool {
        playerDeck?.forward()
        return playerDeck?.current.map(playStation) ?? false
    }
    
    @discardableResult
    func playPrevious() -> Bool {
        playerDeck?.backward()
        return playerDeck?.current.map(playStation) ?? false
    }
}

//MARK: - Private methods
private extension RadioPlayer {
    
    func playStation(_ station: Station) -> Bool {
        guard let item = AVPlayerItem.parse(station: station) else {
            return false
        }
        
        avPlayer = AVPlayer(playerItem: item)
        avPlayer?.volume = Float(volume)
        avPlayer?.play()
        return isPlaying
    }
}
