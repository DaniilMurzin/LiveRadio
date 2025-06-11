//
//  AllStationsView.swift
//  RadioApp
//
//  Created by Daniil Murzin on 12.02.2025.
//

import SwiftUI

struct AllStationsView: View {
    
    private enum Drawing {
        static let headerHorizontalPadding: CGFloat = 20
        static let headerBottomPadding: CGFloat = -10
        static let volumeSliderLeadingPadding: CGFloat = 15
        static let volumeSliderWidth: CGFloat = 48
        static let scrollViewSpacing: CGFloat = 10
        static let emptyStateMinHeight: CGFloat = 150
        static let emptyStateTopPadding: CGFloat = 50
        static let tabBarCellHeight: CGFloat = 123
        static let playerBottomPadding: CGFloat = 30
        static let favoritesLabelPadding: CGFloat = 25
        static let scrollViewMinWidth: CGFloat = 320
    }
    
    typealias Action = () -> Void
    
    let stations: [LocalStation]
    let name: String
    @Binding var volume: Double
    @Binding var selectedStation: LocalStation?
    @Binding var isPlaying: Bool
    @Binding var searchFieldText: String
    let didTapPlayButton: Action
    let didTapBackwardButton: Action
    let didTapForwardButton: Action
    let didTapCell: (LocalStation) -> Void
    let didTapFavoriteButton: (LocalStation) async -> Void
    
    var body: some View {
        HeaderView(name: name)
            .padding(.horizontal, Drawing.headerHorizontalPadding)
            .padding(.bottom, Drawing.headerBottomPadding)
        SearchBarView(searchText: $searchFieldText)
        HStack {
            VolumeSlider(volume: $volume)
                .padding(.leading, Drawing.volumeSliderLeadingPadding)
                .frame(width: Drawing.volumeSliderWidth)
            
            ScrollView {
                ForEach(stations, id: \.stationuuid) { station in
                    let isSelected = station == selectedStation
                    
                    TabBarCell(
                        station,
                        isSelected: isSelected,
                        didTapPlayButton: { didTapCell(station) },
                        didTapFavorites: { await didTapFavoriteButton(station) },
                        isPlaying: isPlaying,
                        type: .allStations,
                        isFavorite: station.isFavorite
                    )
                }
            }
            .frame(minWidth: Drawing.scrollViewMinWidth)
            
        }
        .overlay(
            VStack {
                Spacer()
                PlayerView(
                    isPlaying: $isPlaying,
                    backwardButtonAction: didTapBackwardButton,
                    forwardButtonAction: didTapForwardButton,
                    playButtonAction: didTapPlayButton
                )
                .padding(.bottom, Drawing.playerBottomPadding)
                .background(Color.clear)
            }
        )
    }
    
}


#Preview {
    TabBarBackground {
        AllStationsView(
            stations: [],
            name: "Daniil",
            volume: .constant(0.5),
            selectedStation: .constant(.none),
            isPlaying: .constant(false),
            searchFieldText: .constant("Search"), didTapPlayButton: {},
            didTapBackwardButton: {},
            didTapForwardButton: {},
            didTapCell: {_ in },
            didTapFavoriteButton: {_ in }
        )
    }
}
