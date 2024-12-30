//
//  HeaderView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 30.11.2024.
//

import SwiftUI

struct HeaderView: View {
    
    let name: String
    
    var body: some View {
        HStack {
            Image(.playLabel)
                .resizable()
                .frame(width: 35, height: 35)
            Text("Hello")
                .applyFonts(for: .header)
            Text(name)
                .font(.system(size: 30, weight: .medium))
                .foregroundStyle(.eclipse8)
            Spacer()
            Image(.profilePhoto)
                .resizable()
                .frame(width: 65, height: 70)
                .clipShape(Circle())
        }
        
    }
}

#Preview {
    MainBackground {
        HeaderView(name: "Mark")
    }
    
}
