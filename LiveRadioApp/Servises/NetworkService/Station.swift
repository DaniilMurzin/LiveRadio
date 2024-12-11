//
//  Station.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 14.10.2024.
//

import SwiftUI

struct Station: Codable, Sendable, Hashable {
    let changeuuid: String
    let stationuuid: String
    let name: String
    let url: String
    let urlResolved: String?
    let homepage: String
    let favicon: String
    let tags: String
    let country: String
    let countrycode: String
    let state: String
    let language: String
    let languagecodes: String
    let votes: Int
    let lastchangetime: String
    let codec: String
    let bitrate: Int
    let hls: Int
    let lastcheckok: Int
    let lastchecktime: String
    let lastlocalchecktime: String
    let geoLat: Double?
    let geoLong: Double?

    init(changeuuid: String = "",
         stationuuid: String = "",
         name: String = "",
         url: String = "",
         urlResolved: String = "",
         homepage: String = "",
         favicon: String = "",
         tags: String = "",
         country: String = "",
         countrycode: String = "",
         state: String = "",
         language: String = "",
         languagecodes: String = "",
         votes: Int = 0,
         lastchangetime: String = "",
         codec: String = "",
         bitrate: Int = 0,
         hls: Int = 0,
         lastcheckok: Int = 0,
         lastchecktime: String = "",
         lastlocalchecktime: String = "",
         geoLat: Double? = nil,
         geoLong: Double? = nil) {
        self.changeuuid = changeuuid
        self.stationuuid = stationuuid
        self.name = name
        self.url = url
        self.urlResolved = urlResolved
        self.homepage = homepage
        self.favicon = favicon
        self.tags = tags
        self.country = country
        self.countrycode = countrycode
        self.state = state
        self.language = language
        self.languagecodes = languagecodes
        self.votes = votes
        self.lastchangetime = lastchangetime
        self.codec = codec
        self.bitrate = bitrate
        self.hls = hls
        self.lastcheckok = lastcheckok
        self.lastchecktime = lastchecktime
        self.lastlocalchecktime = lastlocalchecktime
        self.geoLat = geoLat
        self.geoLong = geoLong
    }
}
