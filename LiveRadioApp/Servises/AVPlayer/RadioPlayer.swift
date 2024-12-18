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
    @Published var volume: Double = 0.5 {
           didSet {
               avPlayer?.volume = Float(volume)
           }
       }
    
    func playStation(_ station: Station) {
        guard let url = URL(string: station.url) else {
            print("Ошибка: некорректный URL \(station.url)")
            return
        }
        
        self.avPlayer = AVPlayer(playerItem: AVPlayerItem(url: url))
        self.avPlayer?.play()
        self.isPlaying = true
        self.currentStation = station
        self.avPlayer?.volume = Float(volume)
    }
    
    func pauseStation() {
        self.avPlayer?.pause()
        self.isPlaying = false
    }
    
    func resumeStation() {
        self.avPlayer?.play()
        self.isPlaying = true
    }

    func playNextStation(from stations: [Station]) {
        guard let currentIndex = currentStationIndex, currentIndex < stations.count - 1 else { return }
        let nextStation = stations[currentIndex + 1]
        playStation(nextStation)
        currentStationIndex = currentIndex + 1
    }
    
    func playPreviousStation(from stations: [Station]) {
        guard let currentIndex = currentStationIndex, currentIndex > 0 else { return }
        let previousStation = stations[currentIndex - 1]
        playStation(previousStation)
        currentStationIndex = currentIndex - 1
    }
    
    func handleSelection(_ station: Station, in stations: [Station]) {
        if currentStation == station {
            isPlaying ? pauseStation() : resumeStation()
        } else {
            playStation(station)
            currentStationIndex = stations.firstIndex(where: { $0.stationuuid == station.stationuuid })
        }
    }
}
