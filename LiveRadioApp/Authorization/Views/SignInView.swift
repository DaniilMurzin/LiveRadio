//
//  SignInView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 27.08.2024.
//

#warning("Naming пропертис?")
#warning("Дебаггинг пэдингов - консоль")

import SwiftUI

struct SignInView: View {
    typealias Action = () -> Void
    
    //MARK: - Properties
    @Binding var email: String
    @Binding var password: String
    let didTapForgotPassword: Action
    let didTapSignIn: Action
    let didTapSignUp: Action
    let localization: Localization
    
    //MARK: - Drawing
    private enum Drawing {
        static let playIconFrame = CGSize(width: /*@START_MENU_TOKEN@*/58.0/*@END_MENU_TOKEN@*/, height: 58)
        static let circleFrame = CGSize(width: 40, height: 40)
        static let signInButtonFrame = CGSize(width: 153, height: 62)
        
        static let VStamainckHorizontalPadding: CGFloat = 40
        static let bottomPadding: CGFloat = 30
        static let signUpButtonPadding: CGFloat = 5
    }
    
    //MARK: - Body
    var body: some View {
        OnboardingBackground {
            appLogo
            titleText
            textFields
            forgotPasswordButton
            separator
            signInButton
            signUpButton
        }
    }
    
    //MARK: - Subviews
    private var appLogo: some View {
        Image(.playLabel).resizable()
            .frame(width: Drawing.playIconFrame.width,
                   height: Drawing.playIconFrame.height)
            .padding(.top)
    }
    
    private var titleText: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(localization.SignIn)
                .applyFonts(for: .largeTitle)
            Text(localization.startPlay)
                .applyFonts(for: .buttonText)
                .padding(.bottom)
        }
    }
    
    private var subtitleText: some View {
        Text(localization.startPlay)
            .applyFonts(for: .bodyText)
    }
    
    private var textFields: some View {
        VStack {
            CustomAuthTextField(
                text: $email,
                placeholder: localization.yourEmail,
                labelText: localization.email
            )
            .keyboardType(.emailAddress)
            .padding(.bottom)
            
            CustomAuthTextField(
                text: $password,
                placeholder: localization.yourPassword,
                labelText: localization.password,
                isSecured: true
            )
            .padding(.bottom)
        }
    }
    
    private var forgotPasswordButton: some View {
        Button(action: didTapForgotPassword) {
            Text(localization.forgotPassword)
                .foregroundStyle(.gray)
                .padding(.bottom)
        }
    }
    
    private var separator: some View {
        VStack {
            
            HStack(spacing: 10) {
                
                Rectangle().frame(height: 1)
                    .foregroundStyle(.ellipse9)
                Text(localization.connect)
                    .foregroundStyle(.ellipse9)
                    .lineLimit(1)
                    .applyFonts(for: .montserratSmall)
                Rectangle().frame( height: 1)
                    .foregroundStyle(.ellipse9)
            }
            .padding(.bottom)
            .padding(.horizontal,Drawing.VStamainckHorizontalPadding)
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Circle()
                    .frame(width: Drawing.circleFrame.width,
                           height: Drawing.circleFrame.height)
                    .foregroundStyle(.googleIcon)
                    .overlay (
                        Image(.googlePlus)
                    )
                    .padding(.bottom)
            }
        }
    }
    
    private var signInButton: some View {
        Button(action: didTapSignIn) {
            Rectangle()
                .frame(width: Drawing.signInButtonFrame.width,
                       height: Drawing.signInButtonFrame.height)
                .overlay {
                    Image(.vector).aspectRatio(contentMode: .fit)
                }
                .padding(.bottom, Drawing.signUpButtonPadding)
        }
    }
    
    private var signUpButton: some View {
        Button(action: didTapSignUp) {
            Text(localization.signUp)
                .applyFonts(for: .lightSystemText)
        }
        .padding(.bottom, Drawing.bottomPadding)
    }
}

extension SignInView {
    struct Localization {
        let SignIn: String
        let startPlay: String
        let yourPassword: String
        let yourEmail: String
        let email: String
        let password: String
        let forgotPassword: String
        let connect: String
        let signUp: String
        
        static let develop = Self(
            SignIn: "Sign in",
            startPlay: "To start play",
            yourPassword: "Your password",
            yourEmail: "Your email",
            email: "Email",
            password: "Password",
            forgotPassword: "Forgot password?",
            connect: "Or connect with",
            signUp: "Or Sign Up"
        )
    }
}

//MARK: - Preview
#Preview {
    SignInView(
        email: .constant("email@mail.ru"),
        password: .constant("qwerty"),
        didTapForgotPassword: {},
        didTapSignIn: {},
        didTapSignUp: {},
        localization: .develop
    )
        
}
