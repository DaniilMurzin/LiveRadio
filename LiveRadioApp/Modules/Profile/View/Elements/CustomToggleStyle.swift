//
//  CustomToggleStyle.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 27.07.2025.
//

import SwiftUI


struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Capsule()
                .fill(configuration.isOn ? Color.cyan : Color.gray.opacity(0.4))
                .frame(width: 50, height: 30)

            Circle()
                .fill(Color.eclipse11)
                .frame(width: 24, height: 24)
                .offset(x: configuration.isOn ? 10 : -10)
                .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
        }
        .onTapGesture {
            configuration.isOn.toggle()
        }
    }
}
