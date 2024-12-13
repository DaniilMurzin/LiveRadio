//
//  PlayButtonView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 13.12.2024.
//

import SwiftUI

struct PlayButtonView: View {
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action ) {
            ZStack {
                PlayerButtonsShape()
                    .stroke(lineWidth: 1)
                    .frame(width: 127, height: 127)
                    .foregroundColor(.eclipse8)
                
                PlayerButtonsShape()
                    .stroke(lineWidth: 1)
                    .frame(width: 111, height: 111)
                    .foregroundColor(.eclipse6)
                
                PlayerButtonsShape()
                    .fill(.eclipse8)
                    .frame(width: 89, height: 89)
                
                Image(systemName: "play.fill")
                    .resizable()
                    .frame(width: 37, height: 37)
                    .foregroundColor(.white)
            }
        }
    }
}
