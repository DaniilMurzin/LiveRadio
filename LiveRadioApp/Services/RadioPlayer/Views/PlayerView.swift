//
//  PlayerView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 18.09.2024.
//

import SwiftUI

struct PlayerView: View {
    typealias Action = () -> Void
    @Binding var isPlaying: Bool
    let backwardButtonAction: Action
    let forwardButtonAction: Action
    let playButtonAction: Action
    
    var body: some View {
        HStack(spacing: 20) {
            TrackButtonsView(
                action: backwardButtonAction,
                direction: .backward)
              
            PlayButtonView(isPlaying: $isPlaying, action: playButtonAction)
            
            TrackButtonsView(
                action: forwardButtonAction,
                direction: .forward)
        }
        .background(.clear)
    }
}

#Preview {
        PlayerView(
            isPlaying: .constant(true),
            backwardButtonAction: {},
            forwardButtonAction: {},
            playButtonAction: {})
}
