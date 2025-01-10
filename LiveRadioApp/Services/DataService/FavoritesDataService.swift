//
//  FavoritesDataService.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 10.01.2025.
//

import Foundation
import CoreData

final class FavoritesDataService: ObservableObject {
    
    //MARK: - Properties
    private let container: NSPersistentContainer
    private let containerName = "FavoriteStationContainer"
    private let entityName: String = "FavoriteStationEntity"
    
    @Published private var savedEntities: [FavoriteStationEntity] = []
    
    
    //MARK: - Init
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load persistent stores: \(error)")
            }
            
        }
    }
    
    //MARK: - Methods

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
    }
}
