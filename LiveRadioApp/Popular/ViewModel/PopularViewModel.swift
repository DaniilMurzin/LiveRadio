//
//  PopularViewModel.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 30.08.2024.
//

import SwiftUI

final class PopularViewModel: ObservableObject {
    
    private let networkService: StationDataService
    private let storageManager: StorageManager
    var avPlayer: RadioPlayer
//    let persistenceManager: PersistenceManager

    @Published var fetchedStations: [Station] = []
    @Published var name: String = "Daniil"
    @Published var selectedStation: Station?
    
    @Published var volume: Double = 0.5 {
           didSet { avPlayer.volume = volume }
       }
    
    init(
        networkService: StationDataService,
        avPlayer: RadioPlayer,
//        persistenceManager: PersistenceManager,
        storageManager: StorageManager
    ) {
        self.networkService = networkService
        self.avPlayer = avPlayer
//        self.persistenceManager = persistenceManager
        self.storageManager = storageManager
    }

    @Sendable
    func fetchPopularStations() async {
//        Task {
            do {
                let stations = try await networkService.fetchTop()
                await MainActor.run {
                    self.fetchedStations = stations
                }
            } catch {
                print("Ошибка загрузки станций: \(error.localizedDescription)")
            }
//        }
    }
    
    func handleSelection(_ station: Station) {
        defer {
            selectedStation = avPlayer.currentStation
        }
        if avPlayer.currentStation == station {
            avPlayer.isPlaying.toggle()
            return
        }
        avPlayer.play(stations: fetchedStations) { $0 == station }
    }

    func playNextStation() {
        avPlayer.playNext()
        selectedStation = avPlayer.currentStation
    }

    func playPreviousStation() {
        avPlayer.playPrevious()
        selectedStation = avPlayer.currentStation
    }
    
    func toggleFavorite(for station: Station) async {
        do {
            let contains = try await storageManager.contains(station)
            defer {
                var station = station
//                station.isFavorite = !contains
                if let index = fetchedStations.firstIndex(of: station) {
                    fetchedStations[index] = station                    
                }
            }
            if contains {
                try await storageManager.removeStation(station)
                return
            }
            try await storageManager.saveStation(station)
        } catch {
            
        }
//        persistenceManager.toggleFavorite(station: station)
    }
}
