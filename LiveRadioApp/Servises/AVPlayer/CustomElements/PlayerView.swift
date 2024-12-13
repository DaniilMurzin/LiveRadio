//
//  PlayerView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 18.09.2024.
//

import SwiftUI

struct PlayerView: View {
    typealias Action = () -> Void
    
    let backwardButtonAction: Action
    let forwardButtonAction: Action
    let playButtonAction: Action
    
    var body: some View {
        HStack(spacing: 20) {
            TrackButtonsView(
                action: backwardButtonAction,
                direction: .backward)
              
            PlayButtonView(
                action: playButtonAction)
            
            TrackButtonsView(
                action: forwardButtonAction,
                direction: .forward)
        }
    }
}

#Preview {
        PlayerView(
            backwardButtonAction: {},
            forwardButtonAction: {},
            playButtonAction: {})
}
