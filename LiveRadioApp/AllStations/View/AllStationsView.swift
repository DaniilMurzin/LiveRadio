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
        HeaderView(name: name)
            .padding(.horizontal, Drawing.headerHorizontalPadding)
            .padding(.bottom, Drawing.headerBottomPadding)
        VStack {
            HStack {
                VolumeSlider(volume: $volume)
                    .padding(.leading, Drawing.volumeSliderLeadingPadding)
                    .frame(width: Drawing.volumeSliderWidth)
            }
        }
    }
}

#Preview {
    AllStationsView(
        stations: [LocalStation()],
        name: "Daniil",
        volume: .constant(0.5),
        selectedStation: .constant(.none),
        isPlaying: .constant(false),
        didTapbackButton: {},
        didTapPlayButton: {},
        didTapBackwardButton: {},
        didTapForwardButton: {},
        didTapCell: {_ in },
        didTapFavoriteButton: {_ in }
    )
}
