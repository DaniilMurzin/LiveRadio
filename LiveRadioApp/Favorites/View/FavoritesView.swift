//
//  FavoritesView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 22.12.2024.
//

import SwiftUI

struct FavoritesView: View {
    let stations: [Station]
    @Binding var name: String
    @Binding var isPlaying: Bool
    @Binding var isSelected: Bool
    
    var body: some View {
        TabBarBackground {
            HeaderView(name: $name)
            ForEach(stations, id: \.stationuuid) { station in
                TabBarCell(station,
                           isSelected: isSelected,
                           didTapPlayButton: {},
                           didTapFavorites: {},
                           isPlaying: isPlaying,
                           type: .favorites
                )
            }
        }
    }
}

#Preview {
    FavoritesView(
        stations: Station.mockList,
        name: .constant("Daniil"),
        isPlaying: .constant(false),
        isSelected: .constant(false)
    )
}
