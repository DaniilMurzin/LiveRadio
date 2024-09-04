//
//  AuthorizationView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 27.08.2024.
//

#warning("Naming?")
// размещение ассетов? 
import SwiftUI

struct AuthorizationView: View {
    
    //MARK: - Properties
    @State private var emailText = ""
    @State private var passwordText = ""
    
    //MARK: - Drawing
    private enum Drawing {
        static let SignIn = "Sigh in"
        static let startPlay = "To start play"
        static let yourPassword = "Your password"
        static let yourEmail = "Your email"
        static let email = "Email"
        static let password = "Password"
        static let forgotPassword = "Forgot password?"
        static let connect = "Or connect with"
        
        static let playIconFrame = CGSize(width: /*@START_MENU_TOKEN@*/58.0/*@END_MENU_TOKEN@*/, height: 58)
        static let circleFrame = CGSize(width: 40, height: 40)
        
        static let mainVStackPadding: CGFloat = 30
    }
    //MARK: - Body
    var body: some View {
        
        ZStack {
            Image(.authBG)
            
            VStack(alignment: .leading) {
                Image(.playLabel).resizable()
                    .frame(width: Drawing.playIconFrame.width,
                           height: Drawing.playIconFrame.height)
                
                VStack(alignment: .leading) {
                    Text(Drawing.SignIn)
                        .applyFonts(for: .largeTitle)
                    Text(Drawing.startPlay)
                        .applyFonts(for: .bodyText)
                }
                
                Text(Drawing.email)
                    .applyFonts(for: .bodyText)
                
                CustomAuthTextField(text: $emailText, placeholder: Drawing.yourEmail)
                    .keyboardType(.emailAddress)
                
                Text(Drawing.password)
                    .applyFonts(for: .bodyText)
          
                CustomAuthTextField(text: $passwordText, placeholder: Drawing.yourPassword)
                
                Button( action: {} ) {
                    Text(Drawing.forgotPassword)
                        .foregroundStyle(.gray)
                }
    
                VStack {
                    HStack(spacing: 10) {
                        Rectangle().frame(height: 1)
                            .foregroundStyle(.ellipse9)
                        Text(Drawing.connect)
                            .foregroundStyle(.ellipse9)
                            .lineLimit(1)
                            .applyFonts(for: .montserratSmall)
                        Rectangle().frame( height: 1)
                            .foregroundStyle(.ellipse9)
                    }
                    .padding(.horizontal,Drawing.mainVStackPadding)
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        Circle()
                            .frame(width: Drawing.circleFrame.width, height: Drawing.circleFrame.height)
                            .foregroundStyle(.googleIcon)
                            .overlay (
                                Image(.googlePlus)
                            )
                    }//GoogleIcon
                }
                Button(action: {}) {
                    
                }
            }
            .padding(.horizontal, Drawing.mainVStackPadding)
        }
        .background(Color.mainBg)
    }
}
//MARK: - Preview
#Preview {
    AuthorizationView()
}
