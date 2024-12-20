//
//  ButtonAuth.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 04.09.2024.
//

import SwiftUI

struct ButtonAuth: View {
    var title: String
    
    var body: some View {
        Button(action: {
            print("\(title) button tapped")
        }) {
            Text(title)
                .applyFonts(for: .buttonText)
                .foregroundColor(.white)
                .frame(width: 335, height: 72)
                .shadow(color: Color.blue.opacity(0.5), radius: 10, x: 0, y: 5)
                .background(.eclipse6)
        }
    }
    
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        ButtonAuth(title: "Sent")
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.black)
    }
}

