//
//  ProfileHeader.swift
//  RadioApp
//
//  Created by Daniil Murzin on 27.07.2025.
//

import SwiftUI

struct ProfileHeader: View {
    
    let action: () -> Void
    
    var body: some View {
        HStack {
            BackButton(action: action)
            Spacer()
                Text("Settings")
                    .applyFonts(for: .header)
                    .foregroundStyle(.white)
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
        ProfileHeader(action: {})
    }
}
