//
//  SignUpView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 06.09.2024.
//

import SwiftUI

struct SignUpView: View {
    
    //MARK: - Properties
    @State private var emailText = ""
    @State private var passwordText = ""
    
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
        static let signInButtonFrame = CGSize(width: 153, height: 62)
        static let mainVStackPadding: CGFloat = 40
    }
    
    //MARK: - Body
    var body: some View {
        
        ZStack {
            Image(.authBG)
            VStack(alignment: .leading) {
                Spacer()
                appLogo
                titleText
                textFields
                signInButton
                signUpButton
                Spacer()
            }
            .padding(.horizontal, Drawing.mainVStackPadding)
        }
        .background(Color.mainBg)
    }
    
    //MARK: - Subviews
    private var appLogo: some View {
        Image(.playLabel).resizable()
            .frame(width: Drawing.playIconFrame.width,
                   height: Drawing.playIconFrame.height)
            .padding(.bottom)
    }
    
    private var titleText: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(Drawing.SignIn)
                .applyFonts(for: .largeTitle)
            Text(Drawing.startPlay)
                .applyFonts(for: .buttonText)
                .padding(.bottom)
        }
    }
    
    private var subtitleText: some View {
        Text(Drawing.startPlay)
            .applyFonts(for: .bodyText)
    }
    
    private var textFields: some View {
        VStack {
            CustomAuthTextField(
                text: $emailText,
                placeholder: Drawing.yourName,
                labelText: Drawing.name)
                .padding(.bottom)
            CustomAuthTextField(
                text: $emailText,
                placeholder: Drawing.yourEmail,
                labelText: Drawing.email)
                .keyboardType(.emailAddress)
                .padding(.bottom)
            CustomAuthTextField(text: $passwordText, placeholder: Drawing.yourPassword, labelText: Drawing.password, isSecured: true)
        }
        .padding(.bottom)
    }
    
    private var signInButton: some View {
        Button(action: {
        }) {
            Rectangle()
                .frame(width: Drawing.signInButtonFrame.width,
                       height: Drawing.signInButtonFrame.height)
                .overlay {
                    Image(.vector).aspectRatio(contentMode: .fit)
                }
        }
    }
    
    private var signUpButton: some View {
        Button( action: {} ) {
            Text(Drawing.signUp)
                .applyFonts(for: .lightSystemText)
        }
    }
}

#Preview {
    SignUpView()
}
