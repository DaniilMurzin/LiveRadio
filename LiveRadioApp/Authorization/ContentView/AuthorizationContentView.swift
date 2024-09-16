//
//  AuthorizationContentView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 08.09.2024.
//

import SwiftUI

struct AuthorizationContentView: View {
    #warning("правильно добавил координатор для взаимодействия с экранами вне Authorization экранов?")
    @StateObject var viewModel: AuthorizationViewModel
    @EnvironmentObject var coordinator: RootCoordinator
    
    init(_ viewModel: AuthorizationViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        Group {
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
            case .signUp:
                SignUpView(
                    name:  $viewModel.name,
                    email: $viewModel.email,
                    password: $viewModel.password,
                    didTapRegisterButton: coordinator.showTabBar,
                    didTapSignInButton: viewModel.signIn
                    )
            case .forgotPass:
                ForgotPasswordView(
                    email: $viewModel.email,
                    password: $viewModel.password,
                    didTapBackButton: viewModel.signIn)
            case .forgotPass2:
                ForgotPasswordView2(
                    password: $viewModel.password,
                    confirmPassword: $viewModel.password,
                    didTapChangePasswordButton: coordinator.showTabBar)
            }
        }
    }
}
