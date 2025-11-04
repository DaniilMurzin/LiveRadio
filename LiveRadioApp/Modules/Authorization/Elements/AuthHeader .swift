//
//  AuthHeader .swift
//  RadioApp
//
//  Created by Daniil Murzin on 02.11.2025.
//

import SwiftUI


struct AuthHeader: View {
    enum Style {
        case intro(title: String, subtitle: String)
        case forgotPassword(title: String, onBack: () -> Void)
    }

    let style: Style

    var body: some View {
        VStack(alignment: .leading) {
            switch style {
            case let .intro(title, subtitle):
                Image(.playLabel)
                    .resizable()
                    .frame(width: 58, height: 58)

                Text(title)
                    .applyFonts(for: .largeTitle)
                    .foregroundStyle(.white)

                Text(subtitle)
                    .applyFonts(for: .buttonText)
                    .foregroundStyle(.white)
                    .padding(.bottom)

            case let .forgotPassword(title, onBack):
                BackButton(action: onBack)

                Text(title)
                    .applyFonts(for: .largeTitle)
                    .foregroundStyle(.white)
                    .padding(.bottom)
            }
        }
    }
}

#Preview("Forgot") {
    AuthHeader(style: .forgotPassword(title: "Forgot password", onBack: {}))
}

