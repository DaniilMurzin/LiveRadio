//
//  OnboardingView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 27.08.2024.
//

private enum LocalConstants {
    static let getStartedText = "Let's get started"
    static let appDescriptionText = "Enjoy the best radio stations from your home, don't miss out on anything"
    static let buttonText = "Get started"
    
    
    static let getStartedFrame = CGSize(width: 241, height: 126)
    static let appDescriptionFrame = CGSize(width: 204, height: 82)
    static let buttonFrame = CGSize(width: 300, height: 60)
    static let leadingPadding: CGFloat = 50
    static let topPadding: CGFloat = 200
    static let bottomPadding: CGFloat = 100
    static let spacerHeight: CGFloat = 150
}


import SwiftUI

struct OnboardingView: View {
    var body: some View {
        ZStack {
            BackgroundView()
                .ignoresSafeArea()

            VStack(alignment: .leading) {
                
                Text(LocalConstants.getStartedText)
                    .font(Fonts.largeTitle)
                    .frame(width: LocalConstants.getStartedFrame.width, height: LocalConstants.getStartedFrame.height, alignment: .leading)
                    .foregroundStyle(.white)
                    .lineLimit(2)

                Text(LocalConstants.appDescriptionText)
                    .font(Fonts.bodyText)
                    .lineLimit(3)
                    .frame(width: LocalConstants.appDescriptionFrame.width, height: LocalConstants.appDescriptionFrame.height, alignment: .leading)
                    .foregroundStyle(.white)

                Spacer(minLength: LocalConstants.spacerHeight)

                Button(action: {
                    
                }) {
                    Text(LocalConstants.buttonText)
                        .font(Fonts.buttonText)
                        .foregroundColor(.white)
                        .frame(width: LocalConstants.buttonFrame.width, height: LocalConstants.buttonFrame.height)
                        .background(Color.ellipse8)
                        .cornerRadius(10)
                }
                .padding(.bottom, LocalConstants.bottomPadding)

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding(.leading, 50)
            .padding(.top, 200)
        }
    }
}




#Preview {
    OnboardingView()
}
