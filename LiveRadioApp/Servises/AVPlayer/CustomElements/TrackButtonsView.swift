//
//  TrackButtonsView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 13.12.2024.
//

import SwiftUI

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
