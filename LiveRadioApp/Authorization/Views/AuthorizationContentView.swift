//
//  AuthorizationContentView.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 08.09.2024.
//

import SwiftUI

struct AuthorizationContentView: View {
    @StateObject var viewModel: AuthorizationViewModel
    
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
                    didTapForgotPassword: viewModel.forgotPassword,
                    didTapSignIn: viewModel.signIn,
                    didTapSignUp: viewModel.signUp,
                    localization: .develop
                )
            case .signUp:
                SignUpView()
            case .forgotPass:
                ForgotPasswordView()
            case .forgotPass2:
                ForgotPasswordView2()
            }
        }
    }
}

#Preview {
    AuthorizationContentView(AuthorizationViewModel())
}
