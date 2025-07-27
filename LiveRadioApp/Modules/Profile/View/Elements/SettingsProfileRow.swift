//
//  SettingsProfileRow.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 27.07.2025.
//


import SwiftUI

struct SettingsProfileRow: View {
    var body: some View {
        HStack(spacing: 16) {
            Image(.profilePhoto)
                .resizable()
                .frame(width: 65, height: 70)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text("Daniil Murzin")
                    .foregroundColor(.white)
                Text("Email.@maol.ru")
                    .foregroundColor(.cyan)
            }

            Spacer()

            Image(.edit)
                .resizable()
                .frame(width: 25, height: 25)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.2), lineWidth: 2)
        )
        .listRowBackground(Color.clear)
    }
}
