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
        VStack(alignment: .center) {
            
            Text("\(Int(volume * 100))%")
                .font(.system(size: 12))
                .foregroundStyle(.white)
                .lineLimit(1)
                .padding(.bottom)

            GeometryReader { geometry in
                ZStack {
                    ZStack(alignment: .bottom) {
                        RoundedRectangle(cornerRadius: .infinity)
                            .foregroundStyle(
                                Color.gray.opacity(0.2))
                        RoundedRectangle(cornerRadius: .infinity)
                            .foregroundStyle(.eclipse1)
                            .frame(height: geometry.size.height * CGFloat(volume))
                    }
                    
                    Circle()
                        .foregroundStyle(.eclipse1)
                        .frame(width: 10, height: 10)
                        .position(
                            x: geometry.size.width / 2,
                            y: geometry.size.height - (geometry.size.height * CGFloat(volume))
                        )
                        .gesture(
                            DragGesture()
                                .onChanged { value in

                                    let newVolume = 1 - min(max(0, value.location.y / geometry.size.height), 1)
                                    volume = newVolume
                                }
                        )
                }
            }
            .frame(width: 5, height: 230)
            Image(systemName: volume == 0 ? "speaker.slash" : "speaker.wave.2")
                .resizable()
                .frame(width: 18, height: 16)
                .foregroundColor(.gray)
                .padding(.top)
        }
    }
}

#Preview {
    MainBackground {
        VolumeSlider(volume: .constant(0.5))
    }
}


