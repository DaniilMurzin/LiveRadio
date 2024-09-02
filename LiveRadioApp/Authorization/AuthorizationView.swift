//
//  AuthorizationView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 27.08.2024.
//

import SwiftUI

struct AuthorizationView: View {
    
    private enum Drawing {
        static let SignInText = "Sigh in"
        static let startPlay = "To start play"
        static let email = "Email"
    }
    
    var body: some View {
        ZStack {
            Image(.authBG)
            VStack(alignment: .leading) {
                Image(.playLabel).resizable()
                    .frame(width: /*@START_MENU_TOKEN@*/58.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/58.0/*@END_MENU_TOKEN@*/)
                
                VStack(alignment: .leading) {
                    Text(Drawing.SignInText)
                        .applyFonts(for: .largeTitle)
                    Text(Drawing.startPlay)
                        .applyFonts(for: .bodyText)
                }
                
                Text(Drawing.email)
                    .applyFonts(for: .bodyText)
            }
        }
        .background(Color.mainBg)

    }
}

#Preview {
    AuthorizationView()
}
