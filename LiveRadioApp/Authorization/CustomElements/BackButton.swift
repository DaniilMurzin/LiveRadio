//
//  BackButton.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 06.09.2024.
//

import SwiftUI

struct BackButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(.chevronCustomLeft)
                
        }
    }
}

#Preview {
    BackButton(action: {})
        .background(Color.mainBg)
}
