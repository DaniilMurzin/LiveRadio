//
//  Station.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 14.10.2024.
//

import SwiftUI

#warning("нужно инициализировать или оставить nil?")
struct Station: Codable, Sendable {
    let changeuuid: String?
    let stationuuid: String?
    let name: String?
    let url: String?
    let urlResolved: String?
    let homepage: String?
    let favicon: String?
    let tags: String?
    let country: String?
    let countrycode: String?
    let state: String?
    let language: String?
    let languagecodes: String?
    let votes: Int?
    let lastchangetime: String?
    let codec: String?
    let bitrate: Int?
    let hls: Int?
    let lastcheckok: Int?
    let lastchecktime: String?
    let lastlocalchecktime: String?
    let geoLat: Double?
    let geoLong: Double?
}
