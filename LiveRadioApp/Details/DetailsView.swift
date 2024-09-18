//
//  DetailsView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 18.09.2024.
//

import SwiftUI

struct DetailsView: View {
    //MARK: - Properties
    let localization: Localization
    let didTapbackButton: () -> Void
    
    //MARK: - Body
    var body: some View {
        MainBackground {
            HStack {
                BackButton(action: didTapbackButton)
                Text(localization.playingNow)
                    .foregroundStyle(.white)
            }
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
    DetailsView(localization: .develop, didTapbackButton: {})
}
