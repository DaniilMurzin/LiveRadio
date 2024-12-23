//
//  SingleWaveView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 17.12.2024.
//

import SwiftUI

struct SingleWaveView: View {
    
    //MARK: - Properties
    private static let colors: [Color] = [.eclipse2, .eclipse6, .eclipseGreen, .eclipseYellow, .eclipsePurple, .eclipseMulberry, .eclipseRed, .googleIcon]
    
    @State private var waveColor = colors.randomElement() ?? .eclipse8
    @State private var amplitudes: [CGFloat] = [0, 0, 6, -10, 8, -6, 8, -2, 0, 0]
    @State private var targetAmplitudes: [CGFloat] = [0, 0, 6, -10, 8, -6, 8, -2, 0, 0]
    
    private let timer = Timer.publish(every: 0.185, on: .main, in: .common).autoconnect()

    let isSelected: Bool
    let isPlaying: Bool

    //MARK: - Body
    var body: some View {
        ZStack {
            // Волна
            WaveShape(amplitudes: amplitudes)
                .stroke(.white, lineWidth: 2)
                .frame(width: 97, height: 34)
                .opacity(isSelected ? 1.0 : 0.2)
                .onReceive(timer) { _ in
                    if isSelected && isPlaying{
                        updateAmplitudes()
                    }
                }
                .onAppear {
                    startSmoothAnimation()
                }
            
            Circle()
                .stroke(waveColor, lineWidth: 1)
                .background(Circle().fill(waveColor))
                .frame(width: 8, height: 8)
                .position(x: 5, y: 17)
            
            Circle()
                .stroke(waveColor, lineWidth: 1)
                .background(Circle().fill(waveColor))
                .frame(width: 8, height: 8)
                .position(x: 92, y: 17)
        }
        .frame(width: 97, height: 34)
    }
    
    //MARK: - Methods
    private func updateAmplitudes() {
        let middleAmplitudes = Array(targetAmplitudes[2..<targetAmplitudes.count - 2])
        let shiftedAmplitudes: [CGFloat] = Array(middleAmplitudes.dropFirst()) + [middleAmplitudes.first ?? 0]
        targetAmplitudes.replaceSubrange(2..<targetAmplitudes.count - 2, with: shiftedAmplitudes)
    }
    
    private func startSmoothAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.09, repeats: true) { _ in
            for i in 2..<amplitudes.count - 2 {
                amplitudes[i] += (targetAmplitudes[i] - amplitudes[i]) * 0.8
            }
        }
    }
}

struct WaveShape: Shape {
    let amplitudes: [CGFloat]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let midY = rect.height / 2
        let segmentWidth = width / CGFloat(amplitudes.count - 1)
        
        path.move(to: CGPoint(x: 0, y: midY + amplitudes[0]))
        
        for index in 1..<amplitudes.count {
            let startX = CGFloat(index - 1) * segmentWidth
            let endX = CGFloat(index) * segmentWidth
            
            let controlX1 = startX + segmentWidth / 3
            let controlY1 = midY + amplitudes[index - 1]
            let controlX2 = startX + 2 * segmentWidth / 3
            let controlY2 = midY + amplitudes[index]
            let endY = midY + amplitudes[index]
            
            path.addCurve(to: CGPoint(x: endX, y: endY),
                          control1: CGPoint(x: controlX1, y: controlY1),
                          control2: CGPoint(x: controlX2, y: controlY2))
        }
        return path
    }
}

#Preview {
    VStack {
        SingleWaveView(isSelected: true, isPlaying: true)
            .frame(width: 150, height: 50)
            .background(Color.black)
            .cornerRadius(10)
        SingleWaveView(isSelected: false, isPlaying: true)
            .frame(width: 150, height: 50)
            .background(Color.gray)
            .cornerRadius(10)
    }
    .padding()
    .background(Color.black.edgesIgnoringSafeArea(.all))
}
