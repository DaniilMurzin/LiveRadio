//
//  BackButton.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 06.09.2024.
//

import SwiftUI

struct BackButton: View {
    var body: some View {
        Button(action: {
            print("Tap")
        } ) {
            Image(.chevronCustomLeft)
        }
        .padding()
    }
}

#Preview {
    BackButton()
}
