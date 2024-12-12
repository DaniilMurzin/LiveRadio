//
//  VolumeSlider.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 30.11.2024.
//

import SwiftUI

struct VolumeSlider: View {
    @Binding var volume: Double

    var body: some View {
        VStack(spacing: 16) {
            Text("\(Int(volume))%")
                .font(.system(size: 10, weight: .regular))
                .foregroundColor(.white)

            ZStack {
                Capsule()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 6, height: 170)

                Slider(value: $volume, in: 0...100)
                    .rotationEffect(.degrees(-90))
                    .frame(width: 170)
                    .tint(.eclipse6)
            }

            Image(systemName: volume == 0 ? "speaker.slash.fill" : "speaker.wave.3.fill")
                .foregroundColor(.gray)
                .padding(.top, 8)
        }
        .padding(.vertical, 16)
        .frame(width: 25, height: 320)
    }
}

#Preview {
    MainBackground {
        VolumeSlider(volume: .constant(65))
    }
}


#Preview {
    MainBackground {
        VolumeSlider(volume: .constant(65))
    }
}
