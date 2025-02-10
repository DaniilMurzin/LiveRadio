//
//  PopularView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 30.08.2024.
//

import SwiftUI

struct PopularView: View {
    
    private enum Drawing {
        static let titleSize: CGFloat = 30
        static let headerHorizontalPadding: CGFloat = 20
        static let scrollViewSpacing: CGFloat = 30
        static let gridItemDimensions: CGFloat = 139
        static let columnSpacing: CGFloat = 15
        static let bottomPadding: CGFloat = -10
        static let volumeSliderLeadingPadding: CGFloat = 15
        static let volumeSliderWidth: CGFloat = 48
        static let textPadding: CGFloat = 16
        static let lazyVGridSpacing: CGFloat = 20
        static let playerBottomPadding: CGFloat = 30
    }
    
    typealias Action = () -> Void
    let name: String
    @Binding var volume: Double
    @Binding var selectedStation: LocalStation?
    @Binding var isPlaying: Bool
    let didTapbackButton: Action
    let didTapPlayButton: Action
    let didTapBackwardButton: Action
    let didTapForwardButton: Action
    let didTapCell: (LocalStation) -> Void
    let didTapFavoriteButton: (LocalStation) async -> Void
    
    let stations: [LocalStation]
    
    private let columns = [
        GridItem(
            .flexible(
                minimum: Drawing.gridItemDimensions,
                maximum: Drawing.gridItemDimensions),
            spacing: Drawing.columnSpacing),
        GridItem(
            .flexible(
                minimum: Drawing.gridItemDimensions,
                maximum: Drawing.gridItemDimensions),
            spacing: Drawing.columnSpacing)]
    
    var body: some View {
        HeaderView(name: name)
            .padding(.horizontal, Drawing.headerHorizontalPadding)
            .padding(.bottom, Drawing.bottomPadding)
        
        HStack {
            VolumeSlider(volume: $volume)
                .padding(.leading, Drawing.volumeSliderLeadingPadding)
                .frame(width: Drawing.volumeSliderWidth)
            
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Popular")
                        .applyFonts(for: .subtitle)
                        .foregroundColor(.white)
                        .padding(Drawing.textPadding)
                    
                    LazyVGrid(columns: columns, spacing: Drawing.lazyVGridSpacing) {
                        ForEach(stations, id: \.stationuuid) { station in
                            let isSelected = station == selectedStation
                            
                            TabBarCell(
                                station,
                                isSelected: isSelected,
                                didTapPlayButton: { didTapCell(station) },
                                didTapFavorites: { await didTapFavoriteButton(station) },
                                isPlaying: isPlaying,
                                type: .popular,
                                isFavorite: station.isFavorite
                            )
                        }
                    }
                }
                .padding()
            }
        }
        .overlay {
            VStack {
                Spacer()
                PlayerView(
                    isPlaying: $isPlaying,
                    backwardButtonAction: didTapbackButton,
                    forwardButtonAction: didTapForwardButton,
                    playButtonAction: didTapPlayButton
                )
                .padding(.bottom, Drawing.playerBottomPadding)
                .background(Color.clear)
            }
        }
    }
}

#Preview {
    TabBarBackground {
        PopularView(
            name: "Mark",
            volume: .constant(0.3),
            selectedStation: .constant(nil),
            isPlaying: .constant(true),
            didTapbackButton: {},
            didTapPlayButton: {},
            didTapBackwardButton: {},
            didTapForwardButton: {},
            didTapCell: {_ in },
            didTapFavoriteButton: {_ in },
            stations: []
        )
    }
}

