//
//  NotificationToggle.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 27.07.2025.
//


import SwiftUI

struct NotificationToggle: View {
    @Binding var isOn: Bool

    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(.eclipse10)
                    .frame(width: 36, height: 36)
                Image(systemName: "bell.fill")
                    .foregroundColor(.gray)
            }

            Text("Notifications")
                .applyFonts(for: .regular)

            Spacer()

            Toggle("", isOn: $isOn)
                .labelsHidden()
                .toggleStyle(CustomToggleStyle())
        }
        .foregroundColor(.white)
    }
}

#Preview {
    NotificationToggle(isOn: .constant(true))
}
