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
        static let lazyVGridSpacing: CGFloat = 20
        static let columnSpacing: CGFloat = 10
        static let playerViewTrailingPadding: CGFloat = 16
    }
    
    typealias Action = () -> Void
    @Binding var name: String
    @Binding var volume: Double
    @Binding var selectedStation: Station?
    let didTapbackButton: Action
    let didTapPlayButton: Action
    let didTapBackwardButton: Action
    let didTapForwardButton: Action
    let didTapCell: (Station) -> Void
    
    let stations: [Station]
    
    private let columns = [
        GridItem(.flexible(), spacing: Drawing.columnSpacing),
        GridItem(.flexible(), spacing: Drawing.columnSpacing)
    ]
    
    var body: some View {
        TabBarBackground {
            VStack {
                HeaderView(name: $name)
                    .padding(.horizontal, Drawing.headerHorizontalPadding)
                
                HStack {
                    VolumeSlider(volume: $volume)
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: Drawing.scrollViewSpacing) {
                            Text("Popular")
                                .applyFonts(for: .subtitle)
                                .foregroundColor(.white)
                                .padding(.horizontal, Drawing.headerHorizontalPadding)
                            
                            LazyVGrid(columns: columns, spacing: Drawing.lazyVGridSpacing) {
                                ForEach(stations, id: \.stationuuid) { station in
                                    PopularCell(
                                        station,
                                        isSelected: station == selectedStation
                                    ) {
                                        didTapCell(station)
                                    }
                                    didTapFavorites: {}
                                }
                            }
                        }
                    }
                }
                .padding(.trailing, Drawing.playerViewTrailingPadding)
                
                PlayerView(
                    backwardButtonAction: didTapbackButton,
                    forwardButtonAction: didTapForwardButton,
                    playButtonAction: didTapPlayButton
                )
            }
        }
    }
}

#Preview {
    PopularView(
        name: .constant("Mark"),
        volume: .constant(30),
        selectedStation: .constant(nil),
        didTapbackButton: {},
        didTapPlayButton: {},
        didTapBackwardButton: {},
        didTapForwardButton: {},
        didTapCell: {_ in },
        stations: Station.mockList
    )
}

