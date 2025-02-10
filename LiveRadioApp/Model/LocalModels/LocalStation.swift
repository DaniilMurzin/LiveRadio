//
//  LocalStation.swift
//  RadioApp
//
//  Created by Daniil Murzin on 03.02.2025.
//

import Foundation

struct LocalStation: Hashable, Sendable {
    let stationuuid: String
    let name: String
    let tags: String
    let url : String
    let urlResolved : String?
    let homepage : String
    let favicon : String?
    let country : String
    let language : String
    let votes: Int
    var isFavorite: Bool
    
    init(dto: Station, isFavorite: Bool ) {
        stationuuid = dto.stationuuid
        name = dto.name
        url = dto.url
        urlResolved = dto.urlResolved
        homepage = dto.homepage
        favicon = dto.favicon
        tags = dto.tags
        country = dto.country
        language = dto.language
        votes = dto.votes
        self.isFavorite = isFavorite
    }
    
    init(stationuuid: String = "testUUID",
         name: String = "Test Station",
         tags: String = "Rock, Pop",
         url: String = "https://example.com/stream",
         urlResolved: String? = nil,
         homepage: String = "https://example.com",
         favicon: String? = nil,
         country: String = "USA",
         language: String = "English",
         votes: Int = 100,
         isFavorite: Bool = false
    ) {
        self.stationuuid = stationuuid
        self.name = name
        self.tags = tags
        self.url = url
        self.urlResolved = urlResolved
        self.homepage = homepage
        self.favicon = favicon
        self.country = country
        self.language = language
        self.votes = votes
        self.isFavorite = isFavorite
    }
}
