//
//  Array+LocalStation.swift
//  RadioApp
//
//  Created by Daniil Murzin on 28.02.2025.
//

import Foundation

extension Array where Element == LocalStation {
    init(fetched: [Station], stored: [Station]) {
        let ids = Set(stored.map(\.stationuuid))
        self.init(
            fetched.map { station in
                LocalStation(
                    dto: station,
                    isFavorite: ids.contains(station.stationuuid)
                )
            }
        )
    }
}
