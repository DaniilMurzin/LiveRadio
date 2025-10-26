//
//  FavoriteStationEntity.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 26.10.2025.
//

import CoreData

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
                    debugDescription: "Ошибка: одно из обязательных полей в CoreData nil"
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
