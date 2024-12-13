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
    @Published var currentStation: Station?
    @Published var currentStationIndex: Int?
    private var stations: [Station] = []
    
    var onStationChange: ((Station?) -> Void)?
    
    func setStations(_ stations: [Station]) {
        self.stations = stations
    }
    
    func playStation(_ station: Station) {
        guard let url = URL(string: station.url) else {
            print("Ошибка: некорректный URL \(station.url)")
            return
        }
        let playerItem = AVPlayerItem(url: url)
        self.avPlayer = AVPlayer(playerItem: playerItem)
        self.avPlayer?.play()
        self.isPlaying = true
        self.currentStation = station
        self.currentStationIndex = stations.firstIndex(where: { $0.stationuuid == station.stationuuid })
        onStationChange?(station)
    }
    
    func pauseStation() {
        self.avPlayer?.pause()
        self.isPlaying = false
    }
    
    func resumeStation() {
        self.avPlayer?.play()
        self.isPlaying = true
    }
    
    func playNextStation() {
        guard let currentIndex = currentStationIndex, currentIndex < stations.count - 1 else { return }
        let nextStation = stations[currentIndex + 1]
        playStation(nextStation)
    }
    
    func playPreviousStation() {
        guard let currentIndex = currentStationIndex, currentIndex > 0 else { return }
        let previousStation = stations[currentIndex - 1]
        playStation(previousStation)
    }
    
    func handleSelection(_ station: Station) {
        if currentStation == station {
            isPlaying ? pauseStation() : resumeStation()
        } else {
            playStation(station)
        }
    }
}


