//
//  AuthorizationContentView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 08.09.2024.
//

import SwiftUI

final class Localization: ObservableObject {
    @Published var signIn = "sign in"
}

extension Localization {
    func signUpScreen() -> SignUpView.Localization {
        SignUpView.Localization(
            SignUp: "Войти",
            startPlay: "Начать играть",
            yourPassword: "Ваш пароль",
            yourEmail: "Ваш email",
            yourName: "Ваше имя",
            email: "Электронная почта",
            name: "Имя",
            password: "Пароль",
            signUp: "Или зарегистрируйтесь"
        )
    }
}

struct AuthorizationContentView: View {
    @StateObject var viewModel: AuthorizationViewModel
//    @EnvironmentObject var localization: Localization
    
    init(_ viewModel: AuthorizationViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
// алерты  через OnboardingBackgroundView
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .signIn:
                SignInView(
                    email: $viewModel.email,
                    password: $viewModel.password,
                    signInAction: viewModel.signInActive
                    ? .available(viewModel.signIn)
                    : .unavailable,
                    didTapForgotPassword:
                    viewModel.forgotPassword,
                    didTapSignUp: viewModel.showSignUp,
                    localization: .develop
                )
                .transition(.slide)
                
            case .signUp:
                SignUpView(
                    name:  $viewModel.name,
                    email: $viewModel.email,
                    password: $viewModel.password,
                    signUpAction: viewModel.signUpActive 
                    ? .available(viewModel.signUp)
                    : .unavailable,
                    didTapSignInButton: viewModel.showSignIn,
                    localization: .develop
                )
                .transition(.slide)
                
            case .forgotPass:
                ForgotPasswordView(
                    email: $viewModel.email,
                    password: $viewModel.password,
                    didTapBackButton: viewModel.showSignIn
                )
                .transition(.slide)
                
            case .forgotPass2:
                ForgotPasswordView2(
                    password: $viewModel.password,
                    confirmPassword: $viewModel.password,
                    didTapChangePasswordButton: viewModel.showSignIn
                )
                .transition(.slide)
                
            case .error(_):
                EmptyView()
            }
        }
        .animation(.easeInOut, value: viewModel.state)
    }
}
