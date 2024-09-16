//
//  BackgroundView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 27.08.2024.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        ZStack {
            Image(.gradientBlue).resizable()
            Image(.gradientRed).resizable()
            Image(.dj).resizable()
                .aspectRatio(contentMode: .fill)
            Image(.loginBG).resizable()
        }
        
        .ignoresSafeArea()
        .scaledToFill()
        .opacity(0.8)
    }
}

#Preview {
    BackgroundView()
}
