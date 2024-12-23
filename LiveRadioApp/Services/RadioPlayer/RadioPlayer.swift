//
//  RadioPlayer.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 12.12.2024.
//

import Foundation
import AVFoundation

final class RadioPlayer: ObservableObject {
    
    //MARK: - Properties
    @Published var currentStationIndex: Int?
    @Published var avPlayer: AVPlayer?
    @Published var currentStation: Station? {
        didSet {
            if let station = currentStation {
                playStation(station)
            }
        }
    }
    @Published var isPlaying: Bool = false {
        didSet {
            if isPlaying {
                avPlayer?.play()
            } else {
                avPlayer?.pause()
            }
        }
    }
    @Published var volume: Double = 0.5 {
        didSet {
            avPlayer?.volume = Float(volume)
        }
    }
    
    
    //MARK: - Methods
    func playStation(_ station: Station) {
        guard let url = URL(string: station.url) else {
            print("Ошибка: некорректный URL \(station.url)")
            return
        }
        
        avPlayer = AVPlayer(playerItem: AVPlayerItem(url: url))
        avPlayer?.volume = Float(volume)
        isPlaying = true
    }
    
    func playNextStation(from stations: [Station]) {
        guard let currentIndex = currentStationIndex,
                  currentIndex < stations.count - 1 else { return }
        
        let nextStation = stations[currentIndex + 1]
        currentStation = nextStation
        currentStationIndex = currentIndex + 1
    }
    
    func playPreviousStation(from stations: [Station]) {
        guard let currentIndex = currentStationIndex, currentIndex > 0 else { return }
        let previousStation = stations[currentIndex - 1]
        currentStation = previousStation
        currentStationIndex = currentIndex - 1
    }
    
    func handleSelection(_ station: Station, in stations: [Station]) {
        if currentStation == station {
            isPlaying.toggle()
        } else {
            currentStation = station
            currentStationIndex = stations.firstIndex(
                where: { $0.stationuuid == station.stationuuid }
            )
        }
    }
}
