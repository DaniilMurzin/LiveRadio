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
        
        ZStack {
    
            Color(.mainBg)
                .ignoresSafeArea()
            
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
                
                PlayerView(backwardButtonAction: didTapbackButton, forwardButtonAction: didTapForwardButton, playButtonAction: didTapPlayButton)
            }
            .padding()
        }
    }
}

#Preview {
    PopularView(
        didTapbackButton: {},
        didTapBackwardButton: {},
        didTapForwardButton: {},
        didTapPlayButton: {},
        stations: [Station(name: "radio", tags: "POP", votes: 10)]
    )
}
