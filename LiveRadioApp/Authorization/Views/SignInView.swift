//
//  SignInView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 27.08.2024.
//

import SwiftUI

extension Button {
    init(
        asyncAction: @escaping () async throws -> Sendable,
        @ViewBuilder label: () -> Label
    ) {
        self.init(
            action: { Task(operation: asyncAction) },
            label: label
        )
    }
}

struct SignInView: View {
    typealias Action = () -> Void
    typealias AsyncAction = () async -> Sendable
    
    private enum Drawing {
        static let playLabel = CGSize(width: 58, height: 58)
    }
    //MARK: - Properties
    @Binding  var email: String
    @Binding  var password: String
    
    let signInAction: SignInAction
    
    let didTapForgotPassword: Action
    let didTapSignUp: Action
    let localization: Localization
    
    //MARK: - Body
    var body: some View {
        MainBackground {
            
            Image(.playLabel)
                .resizable()
                .frame(width: Drawing.playLabel.width, height: Drawing.playLabel.height)
                .padding(.top)
            
            Text(localization.SignIn)
                .applyFonts(for: .largeTitle)
            Text(localization.startPlay)
                .applyFonts(for: .buttonText)
                .padding(.bottom)
            
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
            
            
            Button(action: didTapForgotPassword) {
                Text(localization.forgotPassword)
                    .foregroundStyle(.gray)
                    .padding(.bottom)
            }
            
            VStack {
                HStack(spacing: 10) {
                    Rectangle().frame(height: 1)
                        .foregroundStyle(.ellipse9)
                    Text(localization.connect)
                        .foregroundStyle(.ellipse9)
                        .lineLimit(1)
                        .applyFonts(for: .montserratSmall)
                    Rectangle().frame(height: 1)
                        .foregroundStyle(.ellipse9)
                }
                .padding(.bottom)
                .padding(.horizontal, 40)
                
                Button(action: {}) {
                    Circle()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.googleIcon)
                        .overlay(Image(.googlePlus))
                        .padding(.bottom)
                }
            }
            
            ArrowButton(asyncAction: didTapSignIn)
                .opacity(signInAction.isAvailable ? 1 : 0.8)

            Button(action: didTapSignUp) {
                Text(localization.signUp)
                    .applyFonts(for: .lightSystemText)
            }
            .padding(.bottom, 30)
        }
    }
    
    private func didTapSignIn() async {
        guard case .available(let action) = signInAction else {
            return
        }
        _ = await action()
    }
}

extension SignInView {
    //MARK: - SignIn
    enum SignInAction {
        case available(AsyncAction)
        case unavailable
        
        var isAvailable: Bool {
            if case .available = self { return true }
            return false
        }
    }
    
    //MARK: - Localization
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
        signInAction: .unavailable,
        didTapForgotPassword: {},
        didTapSignUp: {},
        localization: .develop
    )
}
