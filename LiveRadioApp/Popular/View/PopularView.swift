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
        let _ = Self._printChanges()
        HeaderView(name: name)
            .padding(.horizontal, Drawing.headerHorizontalPadding)
            .padding(.bottom, -10)
        
        HStack {
            VolumeSlider(volume: $volume)
                .padding(.leading, 15)
                .frame(width: 48)
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Popular")
                        .applyFonts(for: .subtitle)
                        .foregroundColor(.white)
                    LazyVGrid(columns: columns, spacing: 20) {
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
                .frame(width: 190, height: 90)
                .padding(.bottom, 30)
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
