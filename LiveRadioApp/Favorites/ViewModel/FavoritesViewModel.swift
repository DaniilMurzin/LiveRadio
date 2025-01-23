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
    @Published var fetchedStations: [Station] = [] {
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
    
    @Sendable
    func fetchFavoriteStations() async {
        do {
            let stations = try await storageManager.loadStations(nil)
            await MainActor.run {
                self.fetchedStations = stations
            }
        } catch {
            print("Ошибка загрузки избранных станций: \(error.localizedDescription)")
        }
    }
//    func fetchFavoriteStations() {
//        fetchedStations = persistenceManager.savedEntities.compactMap { entity in
//            guard let stationuuid = entity.id,
//                  let name = entity.name,
//                  let url = entity.url,
//                  let urlResolved = entity.urlResolved,
//                  let homepage = entity.homepage,
//                  let favicon = entity.favicon,
//                  let tags = entity.tags,
//                  let country = entity.country,
//                  let language = entity.language else {
//                return nil
//            }
//
//            return Station(
//                stationuuid: stationuuid,
//                name: name,
//                url: url,
//                urlResolved: urlResolved,
//                homepage: homepage,
//                favicon: favicon,
//                tags: tags,
//                country: country,
//                language: language,
//                votes: Int(entity.votes)
//            )
//        }
//    }
    
//    func toggleFavorite(for station: Station) {
//        persistenceManager.toggleFavorite(station: station)
//        fetchFavoriteStations() 
//    }
}
