//
//  ArrowButton.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 16.09.2024.
//

import SwiftUI

struct ArrowButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action ) {
            Rectangle()
                .frame(width: 153, height: 62)
                .overlay {
                    Image(.vector).aspectRatio(contentMode: .fit)
                }
                .foregroundStyle(.ellipse6)
                .padding(.bottom, 5)
                
        }
    }
}

#Preview {
    ArrowButton(action: {})
}
