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
        static let headerHorizontalPadding: CGFloat = 16
        static let scrollViewSpacing: CGFloat = 30
        static let gridItemDimensions: CGFloat = 139
        static let columnSpacing: CGFloat = 15
    }
    
    typealias Action = () -> Void
    @Binding var name: String
    @Binding var volume: Double
    @Binding var selectedStation: Station?
    @Binding var isPlaying: Bool
    let didTapbackButton: Action
    let didTapPlayButton: Action
    let didTapBackwardButton: Action
    let didTapForwardButton: Action
    let didTapCell: (Station) -> Void
    
    let stations: [Station]
    
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
        TabBarBackground {
            VStack {
                HeaderView(name: $name)
                    .padding(.horizontal, Drawing.headerHorizontalPadding)
                
                HStack {
                    VolumeSlider(volume: $volume)
                        .frame(width: 27, height: 253)
                        .padding(.leading, 15)
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: Drawing.scrollViewSpacing) {
                            Text("Popular")
                                .applyFonts(for: .subtitle)
                                .foregroundColor(.white)
                                .padding(.horizontal, Drawing.headerHorizontalPadding)
                            
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(stations, id: \.stationuuid) { station in
                                    PopularCell(
                                        station,
                                        isSelected: station == selectedStation)
                                        { didTapCell(station) }
                                        didTapFavorites: {}
                                }
                            }
                        }
                        .padding()
                    }
                    .padding(.trailing, 30)
                }
                
                PlayerView(
                    isPlaying: $isPlaying,
                    backwardButtonAction: didTapbackButton,
                    forwardButtonAction: didTapForwardButton,
                    playButtonAction: didTapPlayButton
                )
                .frame(width: 225, height: 127)
            }
        }
    }
}

#Preview {
    PopularView(
        name: .constant("Mark"),
        volume: .constant(0.3),
        selectedStation: .constant(nil),
        isPlaying: .constant(true),
        didTapbackButton: {},
        didTapPlayButton: {},
        didTapBackwardButton: {},
        didTapForwardButton: {},
        didTapCell: {_ in },
        stations: Station.mockList
    )
}

