//
//  PlayerView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 18.09.2024.
//

import SwiftUI


struct PlayerView: View {
    
    var body: some View {
        HStack(spacing: 20) {
            TrackButtonsView(action: {}, direction: .backward)
              
            PlayButtonView(action: {})
            TrackButtonsView(action: {}, direction: .forward)
        }
    }
}

struct PlayButtonView: View {
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action ) {
            ZStack {
                PlayerButtonsShape()
                    .stroke(lineWidth: 1)
                    .frame(width: 127, height: 127)
                    .foregroundColor(.ellipse8)
                
                PlayerButtonsShape()
                    .stroke(lineWidth: 1)
                    .frame(width: 111, height: 111)
                    .foregroundColor(.ellipse6)
                
                PlayerButtonsShape()
                    .fill(.ellipse8)
                    .frame(width: 89, height: 89)
                
                Image(systemName: "play.fill")
                    .resizable()
                    .frame(width: 37, height: 37)
                    .foregroundColor(.white)
            }
        }
    }
}

struct TrackButtonsView: View {
    let action: () -> Void
    let direction: TrackDirection
    
    enum TrackDirection {
        case forward
        case backward
    }
    
    var body: some View {
        Button(action: action) {
            ZStack {
                PlayerButtonsShape()
                    .fill(.eclipse1)
                    .frame(width: 46, height: 48)
                Image(systemName: direction == .forward ? "forward.fill" : "backward.fill")
                    .resizable()
                    .frame(width: 17, height: 17)
                    .foregroundColor(.white)
            }
        }
    }
    
    
}

#Preview {
    MainBackground {
        PlayerView()
    }
}


