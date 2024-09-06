//
//  ForgotPasswordView2.swift
//  LiveRadioApp
//
//  Created by Daniil Murzin on 06.09.2024.
//

import SwiftUI

struct ForgotPasswordView2:  View {
    
    //MARK: - Properties
    @State private var passwordText = ""
    @State private var confirmPasswordText = ""
    
    //MARK: - Drawing
    private enum Drawing {
        
        static let forgotPassword = "Forgot password"
        static let yourPassword = "Your password"
        static let password = "Password"
        static let confirm = "Confirm password"
        static let changePassword = "Change password"
        
        static let signInButtonFrame = CGSize(width: 153, height: 62)
        
        static let mainVStackPadding: CGFloat = 40
        static let labelPadding: CGFloat = 0
    }
    
    //MARK: - Body
    var body: some View {
        
        ZStack {
            Image(.authBG)
            VStack(alignment: .leading) {
                Spacer()
                BackButton()
                titleText
                textFields
                Spacer()
                signInButton
                Spacer()
                
            }
            .padding(.horizontal, Drawing.mainVStackPadding)
        }
        .background(Color.mainBg)
    }
    
    //MARK: - Subviews

    private var titleText: some View {
        VStack(alignment: .leading, spacing: 2) {
           
            Text(Drawing.forgotPassword)
                .applyFonts(for: .largeTitle)
                .padding(.bottom, 40)
        }
    }
    
    
    private var textFields: some View {
        VStack {
            CustomAuthTextField(
                text: $passwordText,
                placeholder: Drawing.yourPassword,
                labelText: Drawing.password,
                isSecured: true)
                .padding(.bottom)
            CustomAuthTextField(
                text: $confirmPasswordText,
                placeholder: Drawing.yourPassword,
                labelText: Drawing.confirm,
                isSecured: true)
        }
    }
    
    private var signInButton: some View {
        CustomButtonAuth(title: Drawing.changePassword)
            
    }
}

#Preview {
    ForgotPasswordView2()
}
