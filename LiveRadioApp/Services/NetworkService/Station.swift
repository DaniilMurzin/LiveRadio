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
}

// Mock for preview/tests
extension Station {
    init(   changeuuid: String,
            stationuuid: String,
            name: String,
            url: String,
            votes: Int
    ) {
        self.init(
            changeuuid: changeuuid,
            stationuuid: stationuuid,
            name: name,
            url: url,
            urlResolved: nil,
            homepage: "",
            favicon: "",
            tags: "",
            country: "",
            countrycode: "",
            state: "",
            language: "",
            languagecodes: "",
            votes: votes,
            lastchangetime: "",
            codec: "",
            bitrate: 0,
            hls: 0,
            lastcheckok: 0,
            lastchecktime: "",
            lastlocalchecktime: "",
            geoLat: nil,
            geoLong: nil
        )
    }
    static var mock: Station {
        return Station(
            changeuuid: "1234",
            stationuuid: "5678",
            name: "Test Station",
            url: "https://example.com",
            urlResolved: "https://example.com/stream",
            homepage: "https://example.com/home",
            favicon: "https://example.com/favicon.png",
            tags: "pop, rock",
            country: "USA",
            countrycode: "US",
            state: "California",
            language: "English",
            languagecodes: "en",
            votes: 1000,
            lastchangetime: "2024-01-01T12:00:00Z",
            codec: "mp3",
            bitrate: 128,
            hls: 1,
            lastcheckok: 1,
            lastchecktime: "2024-01-01T12:00:00Z",
            lastlocalchecktime: "2024-01-01T12:00:00Z",
            geoLat: 37.7749,
            geoLong: -122.4194
        )
    }
    
    static var mockList: [Station] {
        return [
            Station(
                changeuuid: "1111",
                stationuuid: "aaaa",
                name: "Pop Hits",
                url: "https://example1.com",
                votes: 200
            ),
            Station(
                changeuuid: "2222",
                stationuuid: "bbbb",
                name: "Rock Classics",
                url: "https://example2.com",
                votes: 300
            ),
            Station(
                changeuuid: "3333",
                stationuuid: "cccc",
                name: "Jazz & Blues",
                url: "https://example3.com",
                votes: 150
            ),
            Station(
                changeuuid: "22223",
                stationuuid: "bbbb",
                name: "Rock Classics",
                url: "https://example2.com",
                votes: 300
            ),
            Station(
                changeuuid: "2222332",
                stationuuid: "bbb2232b",
                name: "Rock Classics",
                url: "https://example2.com",
                votes: 300
            ),
            Station(
                changeuuid: "22222",
                stationuuid: "bbb3232b",
                name: "Rock Classics",
                url: "https://example2.com",
                votes: 300
            ),
            Station(
                changeuuid: "22222",
                stationuuid: "bb2332bb",
                name: "Rock Classics",
                url: "https://example2.com",
                votes: 300
            ),
            Station(
                changeuuid: "223322222",
                stationuuid: "bb2332bb",
                name: "Rock Classics",
                url: "https://example2.com",
                votes: 300
            ),
        ]
    }
}
