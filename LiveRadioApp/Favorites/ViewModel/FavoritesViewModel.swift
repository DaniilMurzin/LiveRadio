//
//  FavoritesViewModel.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 23.12.2024.
//

import Foundation

final class FavoritesViewModel: ObservableObject {
    
    let avPlayer: RadioPlayer
    let persistenceManager: PersistenceManager
    
    @Published var name: String = ""
    @Published var fetchedStations: [Station] = []
    @Published var isPlaying: Bool = false
    @Published var isFavorite: Bool = false
    @Published var volume: Double = 0.0 {
        didSet {
            avPlayer.volume = volume
        }
    }
    
    init(avPlayer: RadioPlayer, persistenceManager: PersistenceManager) {
        self.avPlayer = avPlayer
        self.persistenceManager = persistenceManager
    }
    
    func fetchFavoriteStations() {
        fetchedStations = persistenceManager.savedEntities.compactMap { entity in
            guard let stationuuid = entity.id,
                  let name = entity.name,
                  let url = entity.url,
                  let urlResolved = entity.urlResolved,
                  let homepage = entity.homepage,
                  let favicon = entity.favicon,
                  let tags = entity.tags,
                  let country = entity.country,
                  let language = entity.language else {
                return nil
            }

            return Station(
                stationuuid: stationuuid,
                name: name,
                url: url,
                urlResolved: urlResolved,
                homepage: homepage,
                favicon: favicon,
                tags: tags,
                country: country,
                language: language,
                votes: Int(entity.votes)
            )
        }
    }
    
    func toggleFavorite(for station: Station) {
        persistenceManager.toggleFavorite(station: station)
        fetchFavoriteStations() 
    }
}
