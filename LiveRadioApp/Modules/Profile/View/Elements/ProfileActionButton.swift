//
//  SettingsActionButton.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 27.07.2025.
//


import SwiftUI

struct ProfileActionButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .applyFonts(for: .regular)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.cyan)
                )
        }
        .padding(.horizontal, 20)
    }
}
