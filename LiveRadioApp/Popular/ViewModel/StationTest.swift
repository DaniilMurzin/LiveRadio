//
//  Station.swift
//  LiveRadioApp
//
//  Created by Шаповалов Илья on 30.08.2024.
//

import Foundation

struct StationTest: Hashable {
    
    let stationName: String
    let genre: String
    let numberOfVotes: Int
    
    static let preview = [
        Self(stationName: "Station n2", genre: "POP", numberOfVotes: 2),
        Self(stationName: "Station n3", genre: "ROCK", numberOfVotes: 2),
        Self(stationName: "Station n3", genre: "COUNTRY", numberOfVotes: 2)
    ]
}
