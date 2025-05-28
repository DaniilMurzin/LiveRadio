//
//  FavoritesViewModel.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 23.12.2024.
//

import SwiftUI

final class FavoritesViewModel: ObservableObject {
    
    private let avPlayer: RadioPlayer
    private let storageManager: StorageManager
    
    @Published var name: String = "Daniil"
    @Published var fetchedStations: [LocalStation] = []
    @Published var selectedStation: LocalStation?
    @Published var volume: Double = 0.5 {
        didSet { avPlayer.volume = volume }
    }
    
    var isPlaying: Binding<Bool> {
        Binding (
            get: { self.avPlayer.isPlaying },
            set: { self.avPlayer.isPlaying = $0}
        )
    }
    
    init(avPlayer: RadioPlayer, storageManager: StorageManager) {
        self.avPlayer = avPlayer
        self.storageManager = storageManager
    }
    
    func handleSelection(_ station: LocalStation) {
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
    
    func didTapPlayButton() {
        if let selectedStation = selectedStation {
            handleSelection(selectedStation)
        }
    }
    
    func onAppear()  {
        guard let currentStation = avPlayer.currentStation  else { return }
        selectedStation = currentStation
    }
    
    @MainActor
    func toggleFavorite(for station: LocalStation) async {
        do {
            try await storageManager.removeStation(station)
            if let index = fetchedStations.firstIndex(of: station) {
                        fetchedStations.remove(at: index)
                    }
#warning("??")
//            fetchedStations.removeAll { $0 == station }
        } catch {
            print("Ошибка при переключении избранного: \(error.localizedDescription)")
        }
    }

    
    
    @MainActor
    @Sendable
    func fetchFavoriteStations() async {
        do {
            let stations = try await storageManager.loadStations(nil)
            self.fetchedStations = stations
        } catch {
            print("Ошибка загрузки избранных станций: \(error.localizedDescription)")
        }
    }
}
