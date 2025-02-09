//
//  FavoritesViewModel.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 23.12.2024.
//

import Foundation

final class FavoritesViewModel: ObservableObject {
    
    let avPlayer: RadioPlayer
    let storageManager: StorageManager
    
    @Published var name: String = ""
    @Published var fetchedStations: [LocalStation] = [] {
        didSet {
            print("Fetched stations updated: \(fetchedStations.count) stations")
        }
    }
    @Published var isPlaying: Bool = false
    @Published var isFavorite: Bool = false
    @Published var volume: Double = 0.0 {
        didSet {
            avPlayer.volume = volume
        }
    }
    
    init(avPlayer: RadioPlayer, storageManager: StorageManager) {
        self.avPlayer = avPlayer
        self.storageManager = storageManager
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
