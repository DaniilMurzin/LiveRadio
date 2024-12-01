//
//  PopularView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 30.08.2024.
//

import SwiftUI

struct PopularView: View {
    
    //MARK: - Drawing
    private enum Drawing {
        static let titleSize: CGFloat = 30
    }
    
    //MARK: - Properties
    typealias Action = () -> Void
    @Binding var name: String
    @Binding var volume: Double
    let didTapbackButton: Action
    let didTapBackwardButton: Action
    let didTapForwardButton: Action
    let didTapPlayButton: Action
    
    let stations: [Station]
    
    private let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    //MARK: - Body
    var body: some View {
        TabBarBackground {
            VStack {
                HeaderView(name: $name)
                    .padding(.horizontal)
                HStack {
                    VolumeSlider(volume: $volume)
                    ScrollView {
                        VStack(alignment: .leading, spacing: 30) {
                            
                            Text("Popular")
                                .applyFonts(for: .subtitle)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(stations, id: \.self) { station in
                                    PopularCell(station)
                                }
                            }
                        }
                    }
                    .padding(.trailing)
                }
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
        didTapbackButton: {},
        didTapBackwardButton: {},
        didTapForwardButton: {},
        didTapPlayButton: {},
        stations: [ Station(name: "Radio Jazz", tags: "jazz", votes: 120),
                    Station(name: "Pop Hits", tags: "pop", votes: 340),
                    Station(name: "Classic FM", tags: "classical", votes: 210),
                    Station(name: "Rock Station", tags: "rock", votes: 500),
                    Station(name: "Dance Mix", tags: "dance", votes: 420),
                    Station(name: "Chill Vibes", tags: "chill", votes: 150)]
    )
}
