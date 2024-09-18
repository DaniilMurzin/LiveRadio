//
//  OnboardingView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 27.08.2024.
//

private enum LocalConstants {
    static let getStartedText = "Let's Get started"
    static let appDescriptionText = "Enjoy the best radio stations from your home, don't miss out on anything"
    static let buttonText = "Get started"
    
    
    static let getStartedFrame = CGSize(width: 241, height: 126)
    static let appDescriptionFrame = CGSize(width: 204, height: 82)
    static let buttonFrame = CGSize(width: 300, height: 60)
    static let buttonTopPadding: CGFloat = 250
    static let buttonLeadingPadding: CGFloat = -30
    
}


import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var coordinator: RootCoordinator
    
    var body: some View {
        
        BackgroundView()
            .ignoresSafeArea()
        
        VStack(alignment: .leading) {
            
            Text(LocalConstants.getStartedText)
                .applyFonts(for: .largeTitle)
                .frame(width: LocalConstants.getStartedFrame.width, height: LocalConstants.getStartedFrame.height, alignment: .leading)
                .foregroundStyle(.white)
                .lineLimit(2)
                .opacity(0.4)
                .padding(.leading, -50)
            
            Text(LocalConstants.appDescriptionText)
                .applyFonts(for: .bodyText)
                .lineLimit(3)
                .frame(width: LocalConstants.appDescriptionFrame.width, height: LocalConstants.appDescriptionFrame.height, alignment: .leading)
                .foregroundStyle(.white)
                .padding(.leading, -50)
            
            Button(action: {
                coordinator.showAuthorization()
            }) {
                Text(LocalConstants.buttonText)
                    .applyFonts(for: .buttonText)
                    .foregroundColor(.white)
                    .frame(width: LocalConstants.buttonFrame.width, height: LocalConstants.buttonFrame.height)
                    .background(Color.ellipse8)
                    .cornerRadius(10)
                    .padding(.top, LocalConstants.buttonTopPadding)
                    .padding(.leading, LocalConstants.buttonLeadingPadding)
                
            }
        }
    }
}

#Preview {
    ZStack {
        OnboardingView()
    }
}
