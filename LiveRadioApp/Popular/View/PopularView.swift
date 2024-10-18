//
//  PopularView.swift
//  LiveRadioApp
//
//  Created by Шаповалов Илья on 30.08.2024.
//

import SwiftUI

struct PopularView: View {
    
    //MARK: - Drawing
    private enum Drawing {
        static let titleSize: CGFloat = 30
    }
    
    //MARK: - Properties
    typealias Action = () -> Void
    let didTapbackButton: Action
    let didTapBackwardButton: Action
    let didTapForwardButton: Action
    let didTapPlayButton: Action
    
    let stations: [Station]
    
    private let columns = [
        GridItem(.flexible(), spacing: 30),
        GridItem(.flexible(), spacing: 30)
    ]
    
    //MARK: - Body
    var body: some View {
        
        TabBarBackground {
            ScrollView {
                VStack {
                    LazyVStack(alignment: .leading) {
                        Text("Popular")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                        LazyVGrid(columns: columns) {
                            ForEach(stations, id:\.self) { station in
                                PopularCell(station)
                            }
                        }
                        .padding()
                    }
                    
                    PlayerView(
                        backwardButtonAction: didTapbackButton, forwardButtonAction: didTapForwardButton, playButtonAction: didTapPlayButton)
                }
                .padding()
            }
        }
    }
}
#Preview {
    PopularView(
        didTapbackButton: {},
        didTapBackwardButton: {},
        didTapForwardButton: {},
        didTapPlayButton: {},
        stations: [ Station(name: "Radio Jazz", tags: "jazz", votes: 120),
                    Station(name: "Pop Hits", tags: "pop", votes: 340),
                    Station(name: "Classic FM", tags: "classical", votes: 210),
                    Station(name: "Rock Station", tags: "rock", votes: 500),
                    Station(name: "Dance Mix", tags: "dance", votes: 420),
                    Station(name: "Chill Vibes", tags: "chill", votes: 150),
                    Station(name: "Hip-Hop Beats", tags: "hip-hop", votes: 310),
                    Station(name: "Country Roads", tags: "country", votes: 230),
                    Station(name: "News 24", tags: "news", votes: 180),
                    Station(name: "Sports Live", tags: "sports", votes: 260)  ]
    )
}
