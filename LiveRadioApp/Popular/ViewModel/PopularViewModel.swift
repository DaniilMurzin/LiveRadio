//
//  PopularViewModel.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 30.08.2024.
//

import Foundation
import AVFoundation
import SwiftUI

final class PopularViewModel: ObservableObject {
    let networkService: StationDataService
    @ObservedObject var avPlayer: RadioPlayer
    @Published var fetchedStations: [Station] = []
    @Published var name: String = "Daniil"
    @Published var volume: Double = 50.0
    @Published var selectedStation: Station?
    
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
    
    func bindingForIsPlaying() -> Binding<Bool> {
           Binding(
               get: { self.avPlayer.isPlaying },
               set: { self.avPlayer.isPlaying = $0 }
           )
       }
}
