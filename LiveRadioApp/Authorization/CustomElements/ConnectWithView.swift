//
//  ConnectWithView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 05.10.2024.
//

import SwiftUI

struct ConnectWithView: View {
    let text: String
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Rectangle().frame(height: 1)
                    .foregroundStyle(.ellipse9)
                Text(text)
                    .foregroundStyle(.ellipse9)
                    .lineLimit(1)
                    .applyFonts(for: .montserratSmall)
                Rectangle().frame(height: 1)
                    .foregroundStyle(.ellipse9)
            }
            .padding(.bottom)
            
            Button(action: {}) {
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.googleIcon)
                    .overlay(Image(.googlePlus))
                    .padding(.bottom)
            }
        }
    }
}

#Preview {
    ConnectWithView(text: "Connect with")
}
