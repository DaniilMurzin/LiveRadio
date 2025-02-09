//
//  RadioPlayer.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 12.12.2024.
//

import Foundation
import AVFoundation
import MediaPlayer

final class RadioPlayer: ObservableObject {
    typealias PlayerDeck = Zipper<LocalStation>
    
    //MARK: - Properties
    @Published private var avPlayer: AVPlayer?
    @Published private var playerDeck: PlayerDeck?
    @Published var volume: Double = 0.5 {
        didSet {
            avPlayer?.volume = Float(volume)
        }
    }
    
    var currentStation: LocalStation? { playerDeck?.current }
    var isPlaying: Bool {
        get { avPlayer?.isPlaying ?? false }
        set { avPlayer?.rate = newValue ? 1 : 0 }
    }
    
    init() {
            setupRemoteCommandCenter()
        }
    
    //MARK: - Methods
    @discardableResult
    func play(stations: [LocalStation], selected: (LocalStation) -> Bool) -> Bool {
        playerDeck = PlayerDeck(stations)
        playerDeck?.move(to: selected)
        return playerDeck?.current.map(playStation) ?? false
    }
    
    @discardableResult
    func play(where predicate: (LocalStation) -> Bool) -> Bool {
        playerDeck?.move(to: predicate)
        return playerDeck?.current.map(playStation) ?? false
    }
    
    func setStations(_ stations: [LocalStation]) {
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
    
    func playStation(_ station: LocalStation) -> Bool {
        guard let item = AVPlayerItem.parse(station: station) else {
            return false
        }
        
        configureAudioSession()
        updateNowPlayingInfo(station: station)
        avPlayer = AVPlayer(playerItem: item)
        avPlayer?.volume = Float(volume)
        avPlayer?.play()
        return isPlaying
    }
}

//MARK: - MediaPlayer setup
private extension RadioPlayer {
   
    func configureAudioSession() {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .default, options: [])
            try session.setActive(true, options: [])
        } catch {
            print("Failed to configure audio session: \(error)")
        }
    }
    
    func updateNowPlayingInfo(station: LocalStation) {
            Task {
                var localNowPlayingInfo: [String: Any] = [
                    MPMediaItemPropertyTitle: station.name,
                    MPMediaItemPropertyArtist: station.tags
                ]
                
                if let faviconURLString = station.favicon,
                   let faviconURL = URL(string: faviconURLString) {
                    do {
                        let (data, _) = try await URLSession.shared.data(from: faviconURL)
                        if let image = UIImage(data: data) {
                            let artwork = MPMediaItemArtwork(boundsSize: image.size) { _ in image }
                            localNowPlayingInfo[MPMediaItemPropertyArtwork] = artwork
                        }
                    } catch {
                        print("Failed to load favicon: \(error)")
                    }
                }
                
                await updateNowPlayingInfoOnMainThread(localNowPlayingInfo)
            }
        }
        
        @MainActor
        func updateNowPlayingInfoOnMainThread(_ nowPlayingInfo: [String: Any]) {
            MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
        }

    func setupRemoteCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared()
        
        commandCenter.playCommand.addTarget { [weak self] _ in
            guard let self = self else { return .commandFailed }
            
            if let currentStation = self.currentStation {
                _ = self.play(where: { $0 == currentStation })
                return .success
            }
            return .commandFailed
        }
        
        commandCenter.pauseCommand.addTarget { [weak self] _ in
            guard let self = self else { return .commandFailed }
            self.isPlaying = false
            return .success
        }
        
        commandCenter.nextTrackCommand.addTarget { [weak self] _ in
            guard let self = self else { return .commandFailed }
            
            if self.playNext() {
                return .success
            }
            return .commandFailed
        }
        
        commandCenter.previousTrackCommand.addTarget { [weak self] _ in
            guard let self = self else { return .commandFailed }
            
            if self.playPrevious() {
                return .success
            }
            return .commandFailed
        }
    }

}
