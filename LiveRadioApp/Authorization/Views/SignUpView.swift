//
//  SignUpView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 06.09.2024.
//

import SwiftUI

struct SignUpView: View {
    typealias Action = () -> Void
    
    //MARK: - Properties
    @Binding var name: String
    @Binding var email: String
    @Binding var password: String
    
    let didTapRegisterButton: Action
    let didTapSignInButton: Action
    
    //MARK: - Drawing
    private enum Drawing {
        static let SignIn = "Sign up"
        static let startPlay = "To start play"
        static let yourPassword = "Your password"
        static let yourEmail = "Your email"
        static let yourName = "Your name"
        static let email = "Email"
        static let name = "Name"
        static let password = "Password"
        static let signUp = "Or Sign In"
        
        static let playIconFrame = CGSize(width: /*@START_MENU_TOKEN@*/58.0/*@END_MENU_TOKEN@*/, height: 58)
    }
    
    //MARK: - Body
    var body: some View {
        OnboardingBackground {
            Image(.playLabel).resizable()
                .frame(
                    width: Drawing.playIconFrame.width,
                    height: Drawing.playIconFrame.height)
            
            Text(Drawing.SignIn)
                .applyFonts(for: .largeTitle)
            Text(Drawing.startPlay)
                .applyFonts(for: .buttonText)
                .padding(.bottom)
            
            CustomAuthTextField(
                text: $email,
                placeholder: Drawing.yourName,
                labelText: Drawing.name)
            .padding(.bottom)
            
            CustomAuthTextField(
                text: $email,
                placeholder: Drawing.yourEmail,
                labelText: Drawing.email)
            .keyboardType(.emailAddress)
            .padding(.bottom)
            
            CustomAuthTextField(
                text: $password,
                placeholder: Drawing.yourPassword,
                labelText: Drawing.password,
                isSecured: true)
            .padding(.bottom)
            
            ArrowButton(action: didTapRegisterButton)
            
            Button( action: didTapSignInButton ) {
                Text(Drawing.signUp)
                    .applyFonts(for: .lightSystemText)
            }
        }
    }
}

#Preview {
    OnboardingBackground {
        SignUpView(
            name: .constant("Ivan"),
            email: .constant("email@mail.ru"),
            password: .constant("qwerty"),
            didTapRegisterButton: {},
            didTapSignInButton: {}
        )
    }
}
