//
//  SettingsItemRow.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 27.07.2025.
//


import SwiftUI

struct SettingsItemRow: View {
    
    let title: String
    let icon: String
    let action: () -> Void

    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.1))
                    .frame(width: 36, height: 36)
                Image(systemName: icon)
                    .foregroundColor(.gray)
            }

            Text(title)
                .foregroundColor(.white)
                .applyFonts(for: .regular)

            Spacer()

            Button(action: action) {
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.1))
                        .frame(width: 36, height: 36)
                    Image(systemName: "chevron.right")
                        .foregroundColor(.cyan)
                }
            }
        }
    }
}
