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
    func saveStations(_ stations: [LocalStation]) async throws -> [LocalStation]
    
    @discardableResult
    func saveStation(_ station: LocalStation) async throws -> [LocalStation]

    @discardableResult
    func updateStations(_ stations: [LocalStation]) async throws -> [LocalStation]

    @discardableResult
    func removeStations(_ stations: [LocalStation]) async throws -> [LocalStation]
    
    @discardableResult
    func removeStation(_ station: LocalStation) async throws -> [LocalStation]

    func loadStations(_ predicate: (LocalStation) -> Bool) async throws -> [LocalStation]
    func loadStations(_ predicate: NSPredicate?) async throws -> [LocalStation]
    
    func contains(_ station: LocalStation) async throws -> Bool
    func contains(_ station: Station) async throws -> Bool
    func contains(where predicate: (LocalStation) -> Bool) async throws -> Bool
    func contains(with predicate: NSPredicate) async throws -> Bool
}

extension StorageManager {
    @discardableResult
    func saveStation(_ station: LocalStation) async throws -> [LocalStation] {
        try await saveStations([station])
    }

    @discardableResult
    func removeStation(_ station: LocalStation) async throws -> [LocalStation] {
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
    
    func saveStations(_ stations: [LocalStation]) async throws -> [LocalStation] {
        try await container.performBackgroundTask { context in
            stations
                .map { FavoriteStationEntity($0, in: context) }
                .forEach(context.insert(_:))
            try context.save()
            return stations
        }
    }
    
    func loadStations(
        _ predicate: (LocalStation) -> Bool = { _ in true }
    ) async throws -> [LocalStation] {
        try await loadStations(nil)
    }
    @discardableResult
    func loadStations(_ predicate: NSPredicate? = nil) async throws -> [LocalStation] {
        try await container.performBackgroundTask { [entityName] context in
            let request = NSFetchRequest<FavoriteStationEntity>(entityName: entityName)
            request.predicate = predicate
            let results = try context.fetch(request)
            print("Найдено \(results.count) записей в Core Data")
            return try results.map(LocalStation.init)
        }
    }
    
    func updateStations(_ stations: [LocalStation]) async throws -> [LocalStation] {
        try await saveStations(stations)
    }
    
    func removeStations(_ stations: [LocalStation]) async throws -> [LocalStation] {
        try await container.performBackgroundTask { context in
            try stations
                .compactMap { station in
                    let request = NSFetchRequest<FavoriteStationEntity>(entityName: self.entityName)
                    request.predicate = NSPredicate(format: "id == %@", station.stationuuid)
                    return try context.fetch(request).first
                }
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
    
    func contains(_ station: LocalStation) async throws -> Bool {
        try await contains(with: NSPredicate(format: "id == %@", station.stationuuid))
    }
    
    func contains(_ station: Station) async throws -> Bool {
        try await contains(with: NSPredicate(format: "id == %@", station.stationuuid))
    }
    
    func contains(where predicate: (LocalStation) -> Bool) async throws -> Bool {
        try await contains(with: NSPredicate(format: "id == %@", "invalid"))
    }
}


extension FavoriteStationEntity {
    convenience init(_ entity: LocalStation, in context: NSManagedObjectContext) {
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

extension LocalStation {
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
                LocalStation.self,
                DecodingError.Context(
                    codingPath: [],
                    debugDescription: "Ошибка: одно из обязательных полей в CoreData nil"
                )
            )
        }
        
        self.stationuuid = stationuuid
        self.name = name
        self.url = url
        self.urlResolved = entity.urlResolved
        self.homepage = homepage
        self.favicon = entity.favicon
        self.tags = tags
        self.country = country
        self.language = language
        self.isFavorite = entity.isFavorite
        self.votes = Int(entity.votes)
    }
}

//protocol PersistenceManager {
//    var savedEntities: [FavoriteStationEntity] { get }
//    func toggleFavorite(station: LocalStation)
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
//    func toggleFavorite(station: LocalStation) {
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
//    func add(station: LocalStation) {
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
