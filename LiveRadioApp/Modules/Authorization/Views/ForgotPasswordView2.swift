//
//  ForgotPasswordView2.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 06.09.2024.
//

import SwiftUI

struct ForgotPasswordView2:  View {
    
    //MARK: - Properties
    @Binding var password: String
    @Binding var confirmPassword: String
    
    let didTapChangePasswordButton: () -> Void
    
    //MARK: - Drawing
    private enum Drawing {
        
        static let forgotPassword = "Forgot password"
        static let yourPassword = "Your password"
        static let password = "Password"
        static let confirm = "Confirm password"
        static let changePassword = "Change password"
        
        static let labelPadding: CGFloat = 40
    }
    
    //MARK: - Body
    var body: some View {
        MainBackground {
            BackButton(action: didTapChangePasswordButton)
            
            Text(Drawing.forgotPassword)
                .applyFonts(for: .largeTitle)
                .padding(.bottom, Drawing.labelPadding)
            
            AuthTextField(
                text: $password,
                placeholder: Drawing.yourPassword,
                labelText: Drawing.password,
                isSecured: true)
            .padding(.bottom)
            AuthTextField(
                text: $confirmPassword,
                placeholder: Drawing.yourPassword,
                labelText: Drawing.confirm,
                isSecured: true)
            .padding(.bottom)
            
            ButtonAuth(title: Drawing.changePassword)
                .padding(.top)
            
            Spacer()
        }
    }
}

#Preview {
    MainBackground {
        ForgotPasswordView2(
            password: .constant("qwerty"),
            confirmPassword: .constant("qwerty"),
            didTapChangePasswordButton: {})
    }
}
