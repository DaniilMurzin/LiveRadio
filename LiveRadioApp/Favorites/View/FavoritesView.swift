//
//  FavoritesView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 22.12.2024.
//

import SwiftUI

struct FavoritesView: View {
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
    }
    
    typealias Action = () -> Void

    let stations: [LocalStation]
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

    var body: some View {
        VStack {
            HeaderView(name: name)
                .padding(.horizontal, Drawing.headerHorizontalPadding)
                .padding(.bottom, Drawing.headerBottomPadding)

            HStack {
                VolumeSlider(volume: $volume)
                    .padding(.leading, Drawing.volumeSliderLeadingPadding)
                    .frame(width: Drawing.volumeSliderWidth)

                ScrollView {
                    VStack(alignment: .leading, spacing: Drawing.scrollViewSpacing) {
                        Text("Favorites")
                            .applyFonts(for: .subtitle)
                            .foregroundColor(.white)

                        if stations.isEmpty {
                            Text("Add favorite stations")
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, minHeight: Drawing.emptyStateMinHeight)
                                .multilineTextAlignment(.center)
                                .padding(.top, Drawing.emptyStateTopPadding)
                        } else {
                            ForEach(stations, id: \.stationuuid) { station in
                                let isSelected = station == selectedStation

                                TabBarCell(
                                    station,
                                    isSelected: isSelected,
                                    didTapPlayButton: { didTapCell(station) },
                                    didTapFavorites: { await didTapFavoriteButton(station) },
                                    isPlaying: isPlaying,
                                    type: .favorites,
                                    isFavorite: true
                                )
                                .frame(height: Drawing.tabBarCellHeight)
                            }
                        }
                    }
                    .padding()
                }
            }
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
        FavoritesView(
            stations: [LocalStation()],
            name: "Daniil",
            volume: .constant(0.5),
            selectedStation: .constant(LocalStation()),
            isPlaying: .constant(false),
            didTapbackButton: {},
            didTapPlayButton: {},
            didTapBackwardButton: {},
            didTapForwardButton: {},
            didTapCell: {_ in },
            didTapFavoriteButton: {_ in}
        )
    }
}

