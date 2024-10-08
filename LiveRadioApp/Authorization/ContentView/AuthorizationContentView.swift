//
//  AuthorizationContentView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 08.09.2024.
//

import SwiftUI

struct AuthorizationContentView: View {
    #warning("правильно добавил координатор для взаимодействия с экранами вне Authorization?")
    @StateObject var viewModel: AuthorizationViewModel
    @EnvironmentObject var coordinator: RootCoordinator
    
    init(_ viewModel: AuthorizationViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            switch viewModel.state {
            case .signIn:
                SignInView(
                    email: $viewModel.email,
                    password: $viewModel.password,
                    didTapForgotPassword:
                    viewModel.forgotPassword,
                    didTapSignIn: coordinator.showTabBar,
                    didTapSignUp: viewModel.signUp,
                    localization: .develop
                    
                )
                .transition(.opacity)
            case .signUp:
                SignUpView(
                    name:  $viewModel.name,
                    email: $viewModel.email,
                    password: $viewModel.password,
                    didTapRegisterButton: coordinator.showTabBar,
                    didTapSignInButton: viewModel.signIn
                    )
                .transition(.opacity)
            case .forgotPass:
                ForgotPasswordView(
                    email: $viewModel.email,
                    password: $viewModel.password,
                    didTapBackButton: viewModel.signIn)
                .transition(.opacity)
            case .forgotPass2:
                ForgotPasswordView2(
                    password: $viewModel.password,
                    confirmPassword: $viewModel.password,
                    didTapChangePasswordButton: coordinator.showTabBar)
                .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: viewModel.state)
    }
}
