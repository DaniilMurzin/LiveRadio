//
//  PopularViewModel.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 30.08.2024.
//

import Foundation
import AVFoundation

final class PopularViewModel: ObservableObject {
    
    let networkService: StationDataService
    @Published var fetchedStations: [Station] = []
    @Published var name: String = "Daniil"
    @Published var volume: Double = 50.0
    @Published var avPlayer: RadioPlayer
    @Published var selectedStation: Station?
    
    init(networkService: StationDataService, avPlayer: RadioPlayer) {
        self.networkService = networkService
        self.avPlayer = avPlayer
        
        avPlayer.onStationChange = { [weak self] station in
            self?.selectedStation = station
        }
    }
    
    func fetchPopularStations() {
        Task {
            do {
                let stations = try await networkService.fetchTop()
                await MainActor.run {
                    self.fetchedStations = stations
                    self.avPlayer.setStations(stations)
                }
            } catch {
                print("Ошибка загрузки станций: \(error.localizedDescription)")
            }
        }
    }
    
    func handleSelection(_ station: Station) {
        avPlayer.handleSelection(station)
    }
}
