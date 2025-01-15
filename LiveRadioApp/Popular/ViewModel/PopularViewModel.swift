//
//  PopularViewModel.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 30.08.2024.
//

import SwiftUI

final class PopularViewModel: ObservableObject {
    
    private let networkService: StationDataService
    var avPlayer: RadioPlayer
    let persistenceManager: PersistenceManager

    @Published var fetchedStations: [Station] = []
    @Published var name: String = "Daniil"
    @Published var selectedStation: Station?
    @Published var volume: Double = 0.5 {
           didSet {
               avPlayer.volume = volume
           }
       }
    
    init(
        networkService: StationDataService,
        avPlayer: RadioPlayer,
        persistenceManager: PersistenceManager) {
        self.networkService = networkService
        self.avPlayer = avPlayer
        self.persistenceManager = persistenceManager
    }

    func fetchPopularStations() {
        Task {
            do {
                let stations = try await networkService.fetchTop()
                await MainActor.run {
                    self.fetchedStations = stations
                }
            } catch {
                print("Ошибка загрузки станций: \(error.localizedDescription)")
            }
        }
    }
    
    func handleSelection(_ station: Station) {
        if avPlayer.currentStation == station {
            avPlayer.isPlaying.toggle()
        } else {
            avPlayer.play(stations: fetchedStations) { $0 == station }
        }
        selectedStation = avPlayer.currentStation
    }

    func playNextStation() {
        avPlayer.playNext()
        selectedStation = avPlayer.currentStation
    }

    func playPreviousStation() {
        avPlayer.playPrevious()
        selectedStation = avPlayer.currentStation
    }
    
    func toggleFavorite(for station: Station) {
        persistenceManager.toggleFavorite(station: station)
    }
}
