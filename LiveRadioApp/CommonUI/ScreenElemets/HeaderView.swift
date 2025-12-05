//
//  HeaderView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 30.11.2024.
//

import SwiftUI

struct HeaderView: View {
    
    let name: String
    let didTapProfileButton: Action
    
    var body: some View {
        HStack {
            Image(.playLabel)
                .resizable()
                .frame(width: 35, height: 35)
            Text("Hello")
                .applyFonts(for: .header)
                .foregroundStyle(.white)
            Text(name)
                .font(.system(size: 30, weight: .medium))
                .foregroundStyle(.eclipse8)
            Spacer()
            Button(action: {
            }) {
                Image(.profilePhoto)
                    .resizable()
                    .frame(width: 65, height: 70)
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)
        }
    }
}
