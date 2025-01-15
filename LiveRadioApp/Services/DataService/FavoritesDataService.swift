//
//  FavoritesDataService.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 10.01.2025.
//

import Foundation
import CoreData

//protocol PersistenceManager1 {
//    @discardableResult
//    func saveStations(_ stations: Station...) -> [Station]
//    
//    @discardableResult
//    func updateStations(_ stations: Station...) -> [Station]
//    
//    @discardableResult
//    func removeStations(_ stations: Station...) -> [Station]
//    
//    func loadStations(_ predicate: (Station) -> Bool) -> [Station]
//}

protocol PersistenceManager {
    var savedEntities: [FavoriteStationEntity] { get }
    func toggleFavorite(station: Station)
}

final class FavoritesDataService: ObservableObject {
    
    //MARK: - Properties
    private let container: NSPersistentContainer
    private let containerName = "FavoriteStationContainer"
    private let entityName: String = "FavoriteStationEntity"
    
    @Published internal var savedEntities: [FavoriteStationEntity] = []
     
    //MARK: - Init
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
        fetchFavorites()
    }
    
    //MARK: - Methods
    func toggleFavorite(station: Station) {
        guard let entity = savedEntities.first(where: { $0.id == station.stationuuid }) else {
            add(station: station)
            return
        }
        delete(entity: entity)
    }
}

private extension FavoritesDataService {
    
    func fetchFavorites() {
        let request = NSFetchRequest<FavoriteStationEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Failed to fetch favorites: \(error)")
        }
    }
    
    func add(station: Station) {
        let entity = FavoriteStationEntity(context: container.viewContext)
        entity.id = station.stationuuid
        entity.isFavorite = true
        entity.name =  station.name
        entity.url = station.url
        entity.urlResolved = station.urlResolved
        entity.homepage = station.homepage
        entity.favicon = station.favicon
        entity.tags = station.tags
        entity.country = station.country
        entity.language = station.language
        print("Added to favorites: \(station.name) (\(station.stationuuid))")
        applyChanges()
    }
    
    func save() {
        do {
           try container.viewContext.save()
        } catch let error {
            print("Failed to save favorites: \(error)")
        }
    }
    
    func delete(entity: FavoriteStationEntity) {
           container.viewContext.delete(entity)
           applyChanges()
       }
    
    func applyChanges() {
        save()
        fetchFavorites()
    }
}

extension FavoritesDataService: PersistenceManager {}
