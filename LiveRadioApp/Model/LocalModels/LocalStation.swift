//
//  LocalStation.swift
//  RadioApp
//
//  Created by Daniil Murzin on 03.02.2025.
//

import Foundation

struct LocalStation: Hashable, Sendable{
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
}
