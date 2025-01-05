//
//  FavoritesView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 22.12.2024.
//

import SwiftUI

struct FavoritesView: View {
    
    let stations: [Station]
    @Binding var volume: Double
    @Binding var name: String
    @Binding var isPlaying: Bool
    @Binding var isSelected: Bool
    
    var body: some View {
        TabBarBackground {
            HeaderView(name: name)
                
            HStack {
                VolumeSlider(volume: $volume)
                ScrollView {
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
        .overlay {
            VStack {
                Spacer()
                PlayerView(
                    isPlaying: $isPlaying,
                    backwardButtonAction: {},
                    forwardButtonAction: {},
                    playButtonAction: {}
                )
                .frame(width: 190, height: 90)
                .padding(.bottom, 30)
                .background(Color.clear)
            }
        }
    }
}

#Preview {
    FavoritesView(
        stations: Station.mockList,
        volume: .constant(0.5),
        name: .constant("Daniil"),
        isPlaying: .constant(false),
        isSelected: .constant(false)
    )
}
