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
    @Published var fetchedStations: [Station] = []
    @Published var name: String = "Daniil"
    @Published var selectedStation: Station?
    @Published var volume: Double = 0.5 {
           didSet {
               avPlayer.volume = volume
           }
       }
    init(networkService: StationDataService, avPlayer: RadioPlayer) {
        self.networkService = networkService
        self.avPlayer = avPlayer
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
        avPlayer.handleSelection(station, in: fetchedStations)
        selectedStation = avPlayer.currentStation
    }

    func playNextStation() {
        avPlayer.playNextStation(from: fetchedStations)
        selectedStation = avPlayer.currentStation
    }

    func playPreviousStation() {
        avPlayer.playPreviousStation(from: fetchedStations)
        selectedStation = avPlayer.currentStation
    }
}
