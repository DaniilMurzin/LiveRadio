//
//  FavoritesDataService.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 10.01.2025.
//

import Foundation
import CoreData

protocol StorageManager {
    @discardableResult
    func saveStations(_ stations: [Station]) async throws -> [Station]
    
    @discardableResult
    func saveStation(_ station: Station) async throws -> [Station]

    @discardableResult
    func updateStations(_ stations: [Station]) async throws -> [Station]

    @discardableResult
    func removeStations(_ stations: [Station]) async throws -> [Station]
    
    @discardableResult
    func removeStation(_ station: Station) async throws -> [Station]

    func loadStations(_ predicate: (Station) -> Bool) async throws -> [Station]
    func loadStations(_ predicate: NSPredicate?) async throws -> [Station]
    
    func contains(_ station: Station) async throws -> Bool
    func contains(where predicate: (Station) -> Bool) async throws -> Bool
    func contains(with predicate: NSPredicate) async throws -> Bool
}

extension StorageManager {
    @discardableResult
    func saveStation(_ station: Station) async throws -> [Station] {
        try await saveStations([station])
    }

    @discardableResult
    func removeStation(_ station: Station) async throws -> [Station] {
        try await removeStations([station])
    }
}

final class CoreDateManager {
    private let container: NSPersistentContainer
    private let containerName = "FavoriteStationContainer"
    private let entityName = "FavoriteStationEntity"
    
    private var context: NSManagedObjectContext { container.viewContext }

    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
    }
}

extension CoreDateManager: StorageManager {
    typealias FetchRequest = NSFetchRequest<FavoriteStationEntity>
    
    func saveStations(_ stations: [Station]) async throws -> [Station] {
        try await container.performBackgroundTask { context in
            stations
                .map { FavoriteStationEntity($0, in: context) }
                .forEach(context.insert(_:))
            try context.save()
            return stations
        }
    }
    
    func loadStations(
        _ predicate: (Station) -> Bool = { _ in true }
    ) async throws -> [Station] {
        try await loadStations(nil)
    }

    func loadStations(_ predicate: NSPredicate? = nil) async throws -> [Station] {
        try await container.performBackgroundTask { [entityName] context in
            let request = NSFetchRequest<FavoriteStationEntity>(entityName: entityName)
            request.predicate = predicate
            let results = try context.fetch(request)
            print("Найдено \(results.count) записей в Core Data")
            return try results.map(Station.init)
        }
    }
    
    func updateStations(_ stations: [Station]) async throws -> [Station] {
        try await saveStations(stations)
    }
    
    func removeStations(_ stations: [Station]) async throws -> [Station] {
        try await container.performBackgroundTask { context in
            stations
                .map { FavoriteStationEntity($0, in: context) }
                .forEach(context.delete(_:))
            try context.save()
            return stations
        }
    }
    
    func contains(with predicate: NSPredicate) async throws -> Bool {
        try await container.performBackgroundTask { [entityName] context in
            let request = FetchRequest(entityName: entityName)
            request.predicate = predicate
            return try !context.fetch(request).isEmpty
        }
    }
    
    func contains(_ station: Station) async throws -> Bool {
        try await contains(with: NSPredicate(format: "id == %@", station.stationuuid))
    }
    
    func contains(where predicate: (Station) -> Bool) async throws -> Bool {
        try await contains(with: NSPredicate(format: "id == %@", "invalid"))
    }
}


extension FavoriteStationEntity {
    convenience init(_ entity: Station, in context: NSManagedObjectContext) {
        self.init(context: context)
        id = entity.stationuuid
        name = entity.name
        url = entity.url
        urlResolved = entity.urlResolved
        homepage = entity.homepage
        favicon = entity.favicon
        tags = entity.tags
        country = entity.country
        language = entity.language
        isFavorite = true
    }
}

extension Station {
    init(entity: FavoriteStationEntity) throws {
        guard
            let stationuuid = entity.id,
            let name = entity.name,
            let url = entity.url,
            let homepage = entity.homepage,
            let tags = entity.tags,
            let country = entity.country,
            let language = entity.language
        else {
            throw DecodingError.valueNotFound(
                Station.self,
                DecodingError.Context(
                    codingPath: [],
                    debugDescription: String(reflecting: entity)
                )
            )
        }
        self.init(
            stationuuid: stationuuid,
            name: name,
            url: url,
            urlResolved: entity.urlResolved,
            homepage: homepage,
            favicon: entity.favicon,
            tags: tags,
            country: country,
            language: language,
            votes: Int(entity.votes)
        )
    }
}



//protocol PersistenceManager {
//    var savedEntities: [FavoriteStationEntity] { get }
//    func toggleFavorite(station: Station)
//}
//
//final class FavoritesDataService: ObservableObject {
//    
//    //MARK: - Properties
//    private let container: NSPersistentContainer
//    private let containerName = "FavoriteStationContainer"
//    private let entityName: String = "FavoriteStationEntity"
//    
//    @Published internal var savedEntities: [FavoriteStationEntity] = []
//     
//    //MARK: - Init
//    init() {
//        container = NSPersistentContainer(name: containerName)
//        container.loadPersistentStores { _, error in
//            if let error {
//                fatalError("Failed to load persistent stores: \(error)")
//            }
//        }
//        fetchFavorites()
//    }
//    
//    //MARK: - Methods
//    func toggleFavorite(station: Station) {
//        guard let entity = savedEntities.first(where: { $0.id == station.stationuuid }) else {
//            add(station: station)
//            return
//        }
//        delete(entity: entity)
//    }
//}
//
//private extension FavoritesDataService {
//    
//    func fetchFavorites() {
//        let request = NSFetchRequest<FavoriteStationEntity>(entityName: entityName)
//        do {
//            savedEntities = try container.viewContext.fetch(request)
//        } catch let error {
//            print("Failed to fetch favorites: \(error)")
//        }
//    }
//    
//    func add(station: Station) {
//        let entity = FavoriteStationEntity(context: container.viewContext)
//        entity.id = station.stationuuid
//        entity.isFavorite = true
//        entity.name =  station.name
//        entity.url = station.url
//        entity.urlResolved = station.urlResolved
//        entity.homepage = station.homepage
//        entity.favicon = station.favicon
//        entity.tags = station.tags
//        entity.country = station.country
//        entity.language = station.language
//        print("Added to favorites: \(station.name) (\(station.stationuuid))")
//        applyChanges()
//    }
//    
//    func save() {
//        do {
//           try container.viewContext.save()
//        } catch let error {
//            print("Failed to save favorites: \(error)")
//        }
//    }
//    
//    func delete(entity: FavoriteStationEntity) {
//           container.viewContext.delete(entity)
//           applyChanges()
//       }
//    
//    func applyChanges() {
//        save()
//        fetchFavorites()
//    }
//}
