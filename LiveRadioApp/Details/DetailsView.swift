//
//  DetailsView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 18.09.2024.
//

import SwiftUI

struct DetailsView: View {
    typealias Action = () -> Void
    
    //MARK: - Properties
    let localization: Localization
    let didTapbackButton: Action
    let didTapBackwardButton: Action
    let didTapForwardButton: Action
    let didTapPlayButton: Action
    
    //MARK: - Body
    var body: some View {
        MainBackground {
            HStack {
                  BackButton(action: didTapbackButton)
                  Spacer()
                  Text(localization.playingNow)
                      .foregroundStyle(.white)
                  Spacer()
                  Circle()
                      .frame(width: 45, height: 45)
              }
            
            PlayerView(
                backwardButtonAction: didTapBackwardButton,
                forwardButtonAction: didTapForwardButton,
                playButtonAction: didTapPlayButton
            )
        }
    }
}

//MARK: - DetailsView + Localisation
extension DetailsView {
    struct Localization {
        let playingNow: String
        
        static let develop = Self(
            playingNow: "Playing now"
        )
        
        static let developRussian = Self(
            playingNow: "Играет сейчас"
        )
    }
}

#Preview {
    DetailsView(
        localization: .develop,
        didTapbackButton: {} ,
        didTapBackwardButton: {},
        didTapForwardButton: {},
        didTapPlayButton: {}
    )
}
